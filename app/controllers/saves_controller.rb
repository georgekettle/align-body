class SavesController < ApplicationController
	def index
		@workouts = current_user.workouts
	end

	def toggle
		@workout = Workout.find(params[:workout_id])
		if current_user.workouts.include?(@workout)
			@save = Save.find_by(workout: @workout, user: current_user)
			@save.destroy
		else
			@save = Save.new(workout: @workout, user: current_user)
			@save.save
		end

		respond_to do |format|
			format.turbo_stream
	    format.html         { redirect_to workout_url(@workout) }
	  end
	end
end
