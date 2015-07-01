# == Schema Information
#
# Table name: campaigns
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text(65535)
#  image_url    :text(65535)
#  requirements :text(65535)
#  hashtag      :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  tracking     :text(65535)
#
# Indexes
#
#  index_campaigns_on_user_id  (user_id)
#

class Campaign < ActiveRecord::Base
  belongs_to :user

  serialize :tracking, JSON

  before_save do
    if self.tracking
      self.tracking.each do |key, value|
        value.delete_if { |tag| tag.strip.empty? }
      end
    end
  end

  validate :tracking_structure

  protected
    def tracking_structure
      if self.tracking
        self.tracking.each do |key, value|
          unless %w(hashtags usertags).include? key.to_s
            errors.add :tracking, "has an invalid key: '#{key}'"
          end
          unless value.is_a? Array
            errors.add :tracking, "has an invalid value in its '#{key}' key"
          end
        end
      end
    end
end
