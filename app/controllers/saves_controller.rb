class SavesController < ApplicationController
	def index
		@workouts = current_user.workouts
	end
end
