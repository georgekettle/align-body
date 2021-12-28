class InstructorsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:show, :index]
	skip_after_action :verify_authorized, only: :show
	skip_after_action :verify_policy_scoped, only: :index

	def show
		@instructor = Instructor.find(params[:id])
	end

	def index
		@instructors = Instructor.all
	end
end
