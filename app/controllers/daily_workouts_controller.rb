class DailyWorkoutsController < ApplicationController
	def index
		authorize(:daily_workout)
		start_date = params.fetch(:start_date, Date.today).to_date
		@date_range = start_date.beginning_of_month..start_date.end_of_month
		workout_range = start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week
		@daily_workouts = policy_scope(DailyWorkout.includes(:workout).where(date: workout_range))
	end

	def new
		@daily_workout = DailyWorkout.new
		@date = params.fetch(:start_date, Date.today).to_date
		authorize(@daily_workout)
	end

	def create
		@daily_workout = DailyWorkout.new(daily_workout_params)
		authorize(@daily_workout)
		if @daily_workout.save
			redirect_to daily_workouts_path(start_date: @daily_workout.date), notice: "Workout successfully scheduled"
		else
			@date = @daily_workout.date
			render action: :new
		end
	end

	private

	def daily_workout_params
		params.require(:daily_workout).permit(:workout_id, :date)
	end
end
