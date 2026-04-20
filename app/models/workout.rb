class Workout < ApplicationRecord
  has_many :workout_classes

  validates :wod, presence: true
  validates :tittle, presence: true,
    uniqueness: { message: "Already has a workout with this tittle" }
end
