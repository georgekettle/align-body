class AccountsController < ApplicationController
	skip_after_action :verify_authorized
	def account
		if !cookies[:is_native]
			current_user.set_payment_processor :stripe
			@portal_session = current_user.payment_processor.billing_portal
			@plans =  Stripe::Price.list(active: true, expand:['data.product'])
									.sort_by{ |price| price.unit_amount }
			@subscriptions = current_user.active_subscriptions.map{ |sub| Stripe::Subscription.retrieve(sub.processor_id) }
		end
	end

	# Purely for native to explain that account settings are changed on web
	def account_settings
		@hide_navbar = true
	end
end
