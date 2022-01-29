class WorkoutsController < ApplicationController
	def index
		@daily_workouts = DailyWorkout.where(date: Date.today)
		@todays_workouts = policy_scope(Workout.where(daily_workouts: @daily_workouts))
		@categories = Category.all
	end

	def show
		@workout = Workout.find(params[:id])
		authorize @workout
		@navbar_fixed = true
		@hide_native_navbar = true
	end
end
