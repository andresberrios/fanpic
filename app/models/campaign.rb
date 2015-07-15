# == Schema Information
#
# Table name: campaigns
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :text(65535)
#  image_url       :text(65535)
#  requirements    :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  tracking        :text(65535)
#  cover_image_url :text(65535)
#
# Indexes
#
#  index_campaigns_on_user_id  (user_id)
#

class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :entries

  serialize :requirements, JSON
  serialize :tracking, JSON

  before_save do
    if self.tracking
      self.tracking.each do |key, value|
        value.delete_if { |tag| tag.strip.empty? }
      end
    end
    if self.requirements
      self.requirements.delete_if { |req| req.strip.empty? }
    end
  end

  validate :tracking_structure
  validate :requirements_structure

  protected
    def tracking_structure
      if self.tracking
        if self.tracking.is_a? Hash
          self.tracking.each do |key, value|
            unless %w(hashtags usertags).include? key.to_s
              errors.add :tracking, "has an invalid key: '#{key}'"
            end
            if value.is_a? Array
              value.each do |element|
                unless element.is_a? String
                  errors.add :tracking, "hashtags and usertags should contain only Strings"
                  break
                end
              end
            else
              errors.add :tracking, "the '#{key}' field should be an Array"
            end
          end
        else
          errors.add :tracking, "should be a Hash"
        end
      end
    end

    def requirements_structure
      if self.requirements
        if self.requirements.is_a?(Array)
          self.requirements.each do |requirement|
            unless requirement.is_a? String
              errors.add :requirements, "should contain only Strings"
              break
            end
          end
        else
          errors.add :requirements, "should be an Array"
        end
      end
    end
end
