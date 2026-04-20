class WorkoutClass < ApplicationRecord
  validates :workout, :day, :date, :start_time, :max_capacity, presence: true
  validates :start_time, uniqueness: { scope: :day, message: "already have a class at this time" }
end
