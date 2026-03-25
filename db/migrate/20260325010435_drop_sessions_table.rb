class DropSessionsTable < ActiveRecord::Migration[8.1]
  def change
		drop_table :sessions do |t|
			t.string :name
			t.time :start_time	
			t.integer :max_capacity
			t.datetime :archived_at
			t.datetime :deleted_at

			t.timestamps
		end
  end
end
