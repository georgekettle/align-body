class InstructorsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:show, :index]

	def show
		@instructor = Instructor.find(params[:id])
	end

	def index
		@instructors = Instructor.all
	end
end
