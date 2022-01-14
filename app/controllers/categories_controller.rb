class CategoriesController < ApplicationController
	def show
		@category = Category.find(params[:id])
		authorize @category
		if params[:intensity]
			@workouts = Workout.where(category: @category, intensity: params[:intensity])
		else
			@workouts = @category.workouts
		end
	end
end
