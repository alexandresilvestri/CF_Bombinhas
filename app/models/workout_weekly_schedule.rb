class WorkoutWeeklySchedule < ApplicationRecord
  enum :day_of_week, {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }

  validates :day_of_week, presence: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0, only_integer: true } 
  validates :start_time, presence: true, 
    uniqueness: { scope: :day_of_week, message: "already has a class at this time"}
  
end