class Workout < ApplicationRecord
  belongs_to :category
  belongs_to :instructor
end
