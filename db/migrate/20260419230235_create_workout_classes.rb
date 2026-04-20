class CreateWorkoutClasses < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_classes, id: :uuid do |t|
      t.references :workout, type: :uuid, null: false, foreign_key: true
      t.integer :day, null: false
      t.date :date, null: false
      t.time :start_time, null: false
      t.integer :max_capacity, null: false, default: 16
      t.timestamps
    end
  end
end
