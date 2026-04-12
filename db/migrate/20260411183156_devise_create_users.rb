# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.1]
  def up
    unless table_exists?(:users)
      create_table :users, id: :uuid do |t|
        t.string :email,              null: false, default: ""
        t.string :encrypted_password, null: false, default: ""
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
        t.datetime :remember_created_at
        t.string :first_name
        t.string :last_name
        t.boolean :is_admin
        t.boolean :is_coach
        t.string   :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.timestamps null: false
      end

      add_index :users, :email,                unique: true
      add_index :users, :reset_password_token, unique: true
      add_index :users, :confirmation_token,   unique: true
    end
  end

  def down
    drop_table :users
  end
end
