class Dashboard::WorkoutsController < ApplicationController
	before_action :set_workout, only: [:edit, :update, :destroy]

	def index
		@workouts = Workout.order(:created_at)
		policy_scope(@workouts)
	end

	def edit
	end

	def update
		if @workout.update(workout_params)
			redirect_to edit_dashboard_workout_path(@workout), notice: "Workout successfully updated"
		else
			render :edit
		end
	end

	def destroy
		@workout.destroy
		redirect_to dashboard_workouts_path, notice: "Workout successfully deleted"
	end

	private

	def set_workout
		@workout = Workout.find(params[:id])
		authorize @workout
	end

	def workout_params
		params.require(:workout).permit(:name, :mins, :intensity, :video_url, :category_id, :instructor_id, :membership, :photo)
	end
end