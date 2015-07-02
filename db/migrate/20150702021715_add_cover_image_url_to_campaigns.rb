class AddCoverImageUrlToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :cover_image_url, :text
  end
end
