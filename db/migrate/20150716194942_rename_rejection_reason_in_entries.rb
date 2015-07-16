class RenameRejectionReasonInEntries < ActiveRecord::Migration
  def change
    rename_column :entries, :rejection_reason, :unmet_requirements
  end
end
