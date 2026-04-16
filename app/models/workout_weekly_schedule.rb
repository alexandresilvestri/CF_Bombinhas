class WorkoutWeeklySchedule < ApplicationRecord
  enum :day_of_week, {
    domingo: 0,
    segunda: 1,
    terça: 2,
    quarta: 3,
    quinta: 4,
    sexta: 5,
    sábado: 6
  }

  validates :day_of_week, presence: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :start_time, presence: true,
    uniqueness: { scope: :day_of_week, message: "already has a class at this time" }
end
