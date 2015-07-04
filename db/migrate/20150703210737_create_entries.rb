class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :campaign, index: true
      t.references :user, index: true
      t.string :media_type
      t.string :source
      t.string :external_id
      t.text :external_data
      t.string :status
      t.text :rejection_reason

      t.timestamps null: false
    end
    add_foreign_key :entries, :campaigns
    add_foreign_key :entries, :users
    add_index :entries, [:campaign_id, :source, :external_id], unique: true
    reversible do |dir|
      dir.up do
        execute "ALTER TABLE `entries` CHANGE `external_data` `external_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
      end
    end
  end
end
