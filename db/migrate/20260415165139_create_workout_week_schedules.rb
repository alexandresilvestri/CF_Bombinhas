class CreateWorkoutWeekSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_weekly_schedules, id: :uuid do |t|
      t.integer :week_day, null: false
      t.time :start_time, null: false
      t.integer :max_capacity, null: false
      t.timestamps
    end

    add_index :workout_weekly_schedules, [ :week_day, :start_time ], unique: true
    add_check_constraint :workout_weekly_schedules, "max_capacity > 0", name: "workout_weekly_schedules_max_capacity_positive"
  end
end
