class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.text :description
      t.text :image_url
      t.text :requirements
      t.string :hashtag

      t.timestamps null: false
    end
  end
end
