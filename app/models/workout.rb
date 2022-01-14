class Workout < ApplicationRecord
  include Recommendable
  belongs_to :category
  belongs_to :instructor
  has_one_attached :photo

  enum intensity: {
    low: 0,
    high: 2
  }

  def membership?
    membership
  end
end
