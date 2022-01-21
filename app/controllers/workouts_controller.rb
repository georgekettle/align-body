class WorkoutsController < ApplicationController
	def index
		@todays_workouts = policy_scope(Workout).first(8)
		@categories = Category.all
	end

	def show
		@workout = Workout.find(params[:id])
		authorize @workout
		@navbar_fixed = true
	end
end
