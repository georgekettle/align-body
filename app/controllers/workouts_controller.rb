class WorkoutsController < ApplicationController
	def index
		@workouts = Workout.includes(:category, :instructor).all
	end

	def show
		@workout = Workout.find(params[:id])
	end
end
