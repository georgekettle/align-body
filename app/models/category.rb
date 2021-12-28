class Category < ApplicationRecord
	has_one_attached :photo
	has_many :workouts, dependent: :destroy
end
