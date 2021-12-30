class WorkoutsController < ApplicationController
	def index
		@workouts = Workout.includes(:category, :instructor).all
		@categories = Category.all
		policy_scope(@workouts)
	end

	def show
		@workout = Workout.find(params[:id])
		authorize @workout
		@navbar_fixed = true
		report_view_to_recommender
	end

	private

	def report_view_to_recommender
		Recommender::AddViewJob.perform_later(current_user, @workout, params[:recomm_id])
	end
end
