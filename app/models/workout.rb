class Workout < ApplicationRecord
  include Recommendable
  belongs_to :category
  belongs_to :instructor
  has_one_attached :photo

  enum intensity: {
    low: 0,
    high: 2
  }

  DURATIONS = {
    short: 0...20,
    medium: 20...35,
    long: 35...9999
  }

  def membership?
    membership
  end
end
