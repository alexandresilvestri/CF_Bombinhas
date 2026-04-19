class WorkoutWeeklySchedule < ApplicationRecord
  enum :week_day, {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }

  validates :week_day, presence: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :start_time, presence: true,
    uniqueness: { scope: :week_day, message: "already has a class at this time" }
end
