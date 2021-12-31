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
			Recommender::DeleteBookmarkJob.perform_later(current_user, @workout, params[:recomm_id])
		else
			@save = Save.new(workout: @workout, user: current_user)
			authorize @save
			@save.save
			Recommender::AddBookmarkJob.perform_later(current_user, @workout, params[:recomm_id])
		end

		respond_to do |format|
			format.turbo_stream
	    format.html         { redirect_to workout_url(@workout) }
	  end
	end
end
