class SmsUpgradeController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user!
	skip_after_action :verify_authorized

	def twilio_callback
		if params["SmsStatus"] == "delivered"
			user = User.find(params[:user_id])
			user&.update(upgrade_sms_sent: true)
			render json: { success: true }
		end
	end

	def create
		recipient = current_user.phone
		content = "Hi #{current_user.first_name&.capitalize}, we saw you tried to access a locked workout. To upgrade your membership, go to #{account_url}\n\nPs. you’re doing amazing"
		callback = Rails.env == "production" ? sms_upgrade_callback_url(current_user.id) : "#{ENV['DOMAIN']}#{sms_upgrade_callback_path(current_user.id)}"
		if !current_user.upgrade_sms_sent
			SmsService.send_message(recipient, content, callback)
		end
		render json: { success: true }
	end
end