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
#

class Campaign < ActiveRecord::Base

end
