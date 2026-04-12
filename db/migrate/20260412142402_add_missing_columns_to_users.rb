class AddMissingColumnsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string unless column_exists?(:users, :first_name)
    add_column :users, :last_name, :string unless column_exists?(:users, :last_name)
    add_column :users, :is_admin, :boolean unless column_exists?(:users, :is_admin)
    add_column :users, :is_coach, :boolean unless column_exists?(:users, :is_coach)
    add_column :users, :confirmation_token, :string unless column_exists?(:users, :confirmation_token)
    add_column :users, :confirmed_at, :datetime unless column_exists?(:users, :confirmed_at)
    add_column :users, :confirmation_sent_at, :datetime unless column_exists?(:users, :confirmation_sent_at)
    add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
  end
end
