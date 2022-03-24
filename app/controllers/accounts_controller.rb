class AccountsController < ApplicationController
	skip_after_action :verify_authorized
	def account
	end

	# Purely for native to explain that account settings are changed on web
	def membership
		if cookies[:is_native]
			@hide_navbar = true
		else
			@yearly_savings = {
				monthly: 208,
				quarterly: 312,
				yearly: 416
			}
			current_user.set_payment_processor :stripe
			@portal_session = current_user.payment_processor.billing_portal(return_url: membership_url)
			@plans =  Stripe::Price.list(active: true, expand:['data.product'])
									.select{ |price| price.product.active }
									.sort_by{ |price| price.unit_amount }
			@subscriptions = current_user.active_subscriptions.map{ |sub| Stripe::Subscription.retrieve(sub.processor_id) }
		end
	end
end
