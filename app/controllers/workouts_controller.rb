class WorkoutsController < ApplicationController
	def index
		recommendations = RecommenderService.send_batch([ RecommenderService.get_recommendations(current_user, 20, 'workouts_index') ])
		recommended_workout_ids = recommendations ? recommendations.first['json']['recomms'].map{ |item| item["id"].gsub(/[^\d]/, '') } : []
		@recomm_id = recommendations.first['json']['recommId']
		@workouts = Workout.includes(:category, :instructor).where(id: recommended_workout_ids)
		@categories = Category.all
		policy_scope(@workouts)
	end

	def show
		@workout = Workout.find(params[:id])
		authorize @workout
		@navbar_fixed = true
		send_upgrade_sms if policy(@workout).locked? && !current_user.upgrade_sms_sent
		report_view_to_recommender_later
	end

	private

	def send_upgrade_sms
		recipient = current_user.phone
		content = "Hi #{current_user.first_name&.capitalize}, to upgrade and UNLOCK ALL WORKOUTS on Align Body, go to #{account_url} Love you girl! (We do this to avoid 30% tax by apple/google)"
		callback = Rails.env == "production" ? sms_upgrade_callback_url(current_user.id) : "#{ENV['DOMAIN']}#{sms_upgrade_callback_path(current_user.id)}"
		message = SmsService.send_message(recipient, content, callback)
	end

	def report_view_to_recommender_later
		Recommender::AddViewJob.perform_later(current_user, @workout, params[:recomm_id])
	end
end
