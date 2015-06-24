class ChangeTrackingInCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :tracking, :text
    reversible do |dir|
      dir.up do
        Campaign.find_each do |c|
          c.tracking = {hashtags: [c.hashtag]}
          c.save!
        end
      end
      dir.down do
        Campaign.find_each do |c|
          c.hashtag = c.tracking['hashtags'].first
          c.save!
        end
      end
    end
    remove_column :campaigns, :hashtag, :string
  end
end
