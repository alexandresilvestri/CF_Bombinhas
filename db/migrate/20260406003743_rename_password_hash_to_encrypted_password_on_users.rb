class RenamePasswordHashToEncryptedPasswordOnUsers < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :password_hash, :encrypted_password
  end
end
