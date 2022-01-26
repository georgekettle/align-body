class DailyWorkoutsController < ApplicationController
	def index
		policy_scope(DailyWorkout)
	end
end
