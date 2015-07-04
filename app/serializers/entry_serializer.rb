# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  campaign_id      :integer
#  user_id          :integer
#  media_type       :string(255)
#  source           :string(255)
#  external_id      :string(255)
#  external_data    :text(65535)
#  status           :string(255)
#  rejection_reason :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_entries_on_campaign_id                             (campaign_id)
#  index_entries_on_campaign_id_and_source_and_external_id  (campaign_id,source,external_id) UNIQUE
#  index_entries_on_user_id                                 (user_id)
#

class EntrySerializer < ActiveModel::Serializer
  attributes :id, :campaign_id, :user_id,
             :created_at, :updated_at,
             :media_type, :source, :external_id,
             :status, :rejection_reason,
             :caption, :likes, :comments, :external_user,
             :images, :videos, :hashtags,
             :link, :location, :external_created_at
end
