class CreateWorkouts < ActiveRecord::Migration[8.1]
  def change
    create_table :workouts, id: :uuid do |t|
      t.references :gym, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.text :warm_up
      t.text :skill
      t.text :wod

      t.timestamps
    end
  end
end
