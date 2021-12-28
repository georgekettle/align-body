class WorkoutsController < ApplicationController
	def index
		@workouts = Workout.includes(:category, :instructor).all
		policy_scope(@workouts)
	end

	def show
		@workout = Workout.find(params[:id])
		authorize @workout
		@navbar_fixed = true
	end
end
