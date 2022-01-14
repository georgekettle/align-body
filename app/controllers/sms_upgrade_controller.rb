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
end