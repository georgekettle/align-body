class Instructor < ApplicationRecord
	has_person_name
	has_one_attached :photo
	has_many :workouts, dependent: :destroy
end
