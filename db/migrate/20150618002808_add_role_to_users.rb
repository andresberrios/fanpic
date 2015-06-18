class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    reversible do |dir|
      dir.up do
        User.find_each do |user|
          user.save!
        end
      end
    end
  end
end
