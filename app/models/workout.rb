class Workout < ApplicationRecord
  belongs_to :category
  belongs_to :instructor

  enum difficulty: {
    easy: 0,
    medium: 1,
    hard: 2
  }
end
