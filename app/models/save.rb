class Save < ApplicationRecord
  belongs_to :workout
  belongs_to :user

  validates :user_id, uniqueness: { scope: :workout_id }

  default_scope { order(created_at: :desc) }
end
