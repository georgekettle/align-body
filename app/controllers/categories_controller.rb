class CategoriesController < ApplicationController
	def show
		@category = Category.find(params[:id])
		authorize @category
		if params[:duration]
			duration_range = Workout::DURATIONS[params[:duration].to_sym]
			@workouts = Workout.where(category: @category, mins: duration_range)
		else
			@workouts = @category.workouts
		end
	end
end
