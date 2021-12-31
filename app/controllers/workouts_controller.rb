class WorkoutsController < ApplicationController
	def index
		recommendations = RecommenderService.send_batch([ RecommenderService.get_recommendations(current_user, 20, 'workouts_index') ])
		recommended_ids = recommendations.first['json']['recomms'].map{ |item| item["id"].gsub(/[^\d]/, '') }
		@workouts = Workout.includes(:category, :instructor).where(id: recommended_ids)
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
