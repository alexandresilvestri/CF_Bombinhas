class CreateTenants < ActiveRecord::Migration[8.1]
  def change
    create_table :tenants do |t|
      t.integer :stripe_customer_id
      t.string :name, null: false
      t.string :corporate_name
      t.string :cnpj
      t.string :address
      t.string :representative_name
      t.string :representative_cpf

      t.timestamps
    end
  end
end
