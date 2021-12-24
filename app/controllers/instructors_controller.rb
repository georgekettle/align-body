class InstructorsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:show]

	def show
		@instructor = Instructor.find(params[:id])
	end
end
