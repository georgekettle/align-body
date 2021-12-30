class SavesController < ApplicationController	
	def index
		@workouts = current_user.workouts
		policy_scope(@workouts)
	end

	def toggle
		@workout = Workout.find(params[:workout_id])
		if current_user.workouts.include?(@workout)
			@save = Save.find_by(workout: @workout, user: current_user)
			authorize @save
			@save.destroy
		else
			@save = Save.new(workout: @workout, user: current_user)
			authorize @save
			@save.save
		end

		report_bookmark

		respond_to do |format|
			format.turbo_stream
	    format.html         { redirect_to workout_url(@workout) }
	  end
	end

	private

	def report_bookmark
    RecommenderService.report_bookmark(current_user, @workout, @save, params[:recomm_id])
  end
end
