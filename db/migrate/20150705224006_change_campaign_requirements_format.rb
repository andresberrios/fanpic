class ChangeCampaignRequirementsFormat < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute 'UPDATE `campaigns` SET `campaigns`.`requirements` = CONCAT("[\"", `campaigns`.`requirements`, "\"]") WHERE `campaigns`.`requirements` IS NOT NULL;'
      end
    end
  end
end
