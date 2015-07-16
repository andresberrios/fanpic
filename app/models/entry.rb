# == Schema Information
#
# Table name: entries
#
#  id                 :integer          not null, primary key
#  campaign_id        :integer
#  user_id            :integer
#  media_type         :string(255)
#  source             :string(255)
#  external_id        :string(255)
#  external_data      :text(65535)
#  status             :string(255)
#  unmet_requirements :text(65535)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  rejection_message  :text(65535)
#
# Indexes
#
#  index_entries_on_campaign_id                             (campaign_id)
#  index_entries_on_campaign_id_and_source_and_external_id  (campaign_id,source,external_id) UNIQUE
#  index_entries_on_user_id                                 (user_id)
#

class Entry < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user

  serialize :external_data, JsonMashCoder
  serialize :unmet_requirements, JSON

  validates_inclusion_of :source, in: ['instagram']
  validates_inclusion_of :status, in: ['accepted', 'rejected']
  validates_inclusion_of :media_type, in: ['image', 'video']
  after_initialize :set_defaults
  validate :unmet_requirements_structure

  def set_defaults
    self.status ||= 'accepted'
  end

  def self.from_external(source, data)
    self.new source: source,
             media_type: data.type,
             external_id: data.id,
             external_data: data
  end

  def missing_usertags
    if @missing_usertags
      @missing_usertags
    else
      @missing_usertags = []
      if (usertags = self.campaign.tracking['usertags']) && (caption = self.caption)
        caption = caption.text.downcase
        usertags.each do |usertag|
          base_string = "@#{usertag.downcase}"
          included = false
          [' ', "\n", '@', '#'].each do |char|
            if caption.include?(base_string + char)
              included = true
              break
            end
          end
          @missing_usertags.push usertag unless included
        end
      end
      @missing_usertags
    end
  end

  def caption
    self.external_data.caption
  end

  def likes
    self.external_data.likes
  end

  def comments
    self.external_data.comments
  end

  def external_user
    self.external_data.user
  end

  def images
    self.external_data.images
  end

  def videos
    self.external_data.videos
  end

  def hashtags
    self.external_data.tags
  end

  def link
    self.external_data.link
  end

  def location
    self.external_data.location
  end

  def external_created_at
    Time.zone.at self.external_data.created_time.to_i
  end

  protected
    def unmet_requirements_structure
      if self.unmet_requirements
        if self.unmet_requirements.is_a?(Array)
          self.unmet_requirements.each do |unmet_requirement|
            unless unmet_requirement.is_a? String
              errors.add :unmet_requirements, "should contain only Strings"
              break
            end
          end
        else
          errors.add :unmet_requirements, "should be an Array"
        end
      end
    end
end
