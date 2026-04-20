class CreateWorkouts < ActiveRecord::Migration[8.1]
  def change
    create_table :workouts, id: :uuid do |t|
      t.string :tittle, null: false
      t.text :warmup
      t.text :skill
      t.text :wod, null: false
      t.string :wod_type
      t.integer :timecap
      t.text :notes
      t.date :archived_at
      t.timestamps
    end

    add_index :workouts, :tittle, unique: true
  end
end
