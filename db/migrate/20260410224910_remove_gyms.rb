class RemoveGyms < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :workouts, :gyms
    drop_table :gyms, id: :uuid do |t|
      t.string "corporate_name"
      t.datetime "created_at", null: false
      t.string "name", null: false
      t.string "subdomain"
      t.datetime "updated_at", null: false
      t.index [ "subdomain" ], unique: true
    end
    remove_column :workouts, :gym_id, :uuid
  end
end
