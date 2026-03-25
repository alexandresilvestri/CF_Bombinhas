class CreateWorkouts < ActiveRecord::Migration[8.1]
  def change
    create_table :workouts do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name, null: false
      t.time :start_time, null: false
      t.integer :max_capacity, null: false

      t.timestamps
    end
  end
end
