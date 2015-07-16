class AddRejectionMessageToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :rejection_message, :text
  end
end
