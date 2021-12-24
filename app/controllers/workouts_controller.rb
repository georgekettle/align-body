class WorkoutsController < ApplicationController
	def index
		@workouts = Workout.includes(:category, :instructor).all
	end
end
