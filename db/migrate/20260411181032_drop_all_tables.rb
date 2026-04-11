class DropAllTables < ActiveRecord::Migration[8.1]
  def up
    drop_table :workouts, if_exists: true
    drop_table :users, if_exists: true
  end

  def down
    create_table :users, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :email
      t.boolean :email_confirm
      t.string :encrypted_password
      t.string :first_name
      t.boolean :is_admin, default: false, null: false
      t.boolean :is_coach, default: false, null: false
      t.string :last_name
      t.datetime :remember_created_at
      t.datetime :reset_password_sent_at
      t.string :reset_password_token
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :workouts, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :name, null: false
      t.text :warm_up
      t.text :skill
      t.text :wod
      t.timestamps
    end
  end
end
