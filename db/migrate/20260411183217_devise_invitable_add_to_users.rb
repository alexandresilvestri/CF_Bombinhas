class DeviseInvitableAddToUsers < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :invitation_token, :string unless column_exists?(:users, :invitation_token)
    add_column :users, :invitation_created_at, :datetime unless column_exists?(:users, :invitation_created_at)
    add_column :users, :invitation_sent_at, :datetime unless column_exists?(:users, :invitation_sent_at)
    add_column :users, :invitation_accepted_at, :datetime unless column_exists?(:users, :invitation_accepted_at)
    add_column :users, :invitation_limit, :integer unless column_exists?(:users, :invitation_limit)
    unless column_exists?(:users, :invited_by_type)
      add_reference :users, :invited_by, polymorphic: true
    end
    add_column :users, :invitations_count, :integer, default: 0 unless column_exists?(:users, :invitations_count)
    add_index :users, :invitation_token, unique: true unless index_exists?(:users, :invitation_token)
    add_index :users, :invited_by_id unless index_exists?(:users, :invited_by_id)
  end

  def down
    change_table :users do |t|
      t.remove_references :invited_by, polymorphic: true
      t.remove :invitations_count, :invitation_limit, :invitation_sent_at, :invitation_accepted_at, :invitation_token, :invitation_created_at
    end
  end
end
