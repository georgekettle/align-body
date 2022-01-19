class WorkoutsController < ApplicationController
	def index
		@workouts = Workout.order(:created_at)
		@categories = Category.all
		policy_scope(@workouts)
	end

	def show
		@workout = Workout.find(params[:id])
		authorize @workout
		@navbar_fixed = true
	end
end
