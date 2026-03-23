class RemoveArchivedAtAndDeletedAtFromSessions < ActiveRecord::Migration[8.1]
  def change
    remove_column :sessions, :archived_at, :datetime
    remove_column :sessions, :deleted_at, :datetime
  end
end
