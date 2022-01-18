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
		send_upgrade_sms if policy(@workout).locked? && !current_user.upgrade_sms_sent
	end

	private

	def send_upgrade_sms
		recipient = current_user.phone
		content = "Hi #{current_user.first_name&.capitalize}, we saw you tried to access a locked workout. To upgrade your membership, go to #{account_url}\n\nPs. you’re doing amazing"
		callback = Rails.env == "production" ? sms_upgrade_callback_url(current_user.id) : "#{ENV['DOMAIN']}#{sms_upgrade_callback_path(current_user.id)}"
		message = SmsService.send_message(recipient, content, callback)
	end
end
