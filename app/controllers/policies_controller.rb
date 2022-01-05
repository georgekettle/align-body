class PoliciesController < ApplicationController
	skip_before_action :authenticate_user!
	skip_after_action :verify_authorized

	def terms
	end

	def privacy
	end
end
