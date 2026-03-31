class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.boolean :email_confirm
      t.string :password_hash
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
