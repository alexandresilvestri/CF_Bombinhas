class AddAdminCoachBooleanToUsersTable < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :is_admin, :boolean, null: false, default: false
    add_column :users, :is_coach, :boolean, null: false, default: false
  end
end
