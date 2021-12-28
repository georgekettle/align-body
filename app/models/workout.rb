class Workout < ApplicationRecord
  belongs_to :category
  belongs_to :instructor
  has_one_attached :photo

  enum difficulty: {
    easy: 0,
    medium: 1,
    hard: 2
  }

  def membership?
    membership
  end
end
