class AddSubdomainToGyms < ActiveRecord::Migration[8.0]
  def change
    add_column :gyms, :subdomain, :string
    add_index :gyms, :subdomain, unique: true
  end
end
