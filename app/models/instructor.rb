class Instructor < ApplicationRecord
	has_person_name
	has_one_attached :photo
end
