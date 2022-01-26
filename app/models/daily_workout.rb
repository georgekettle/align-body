class DailyWorkout < ApplicationRecord
  belongs_to :workout
  validates :date, presence: true, uniqueness: { scope: :workout_id, message: "You can only schedule a workout once per day" }
end
