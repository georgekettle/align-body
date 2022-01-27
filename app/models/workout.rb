class Workout < ApplicationRecord
  belongs_to :category
  belongs_to :instructor
  has_many :daily_workouts, dependent: :destroy
  has_one_attached :photo

  enum intensity: {
    low: 0,
    high: 2
  }

  default_scope { order(created_at: :desc) }

  def membership?
    membership
  end
end
