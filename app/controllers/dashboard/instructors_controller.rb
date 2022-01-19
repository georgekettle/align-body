class Dashboard::InstructorsController < ApplicationController
	before_action :set_instructor, only: [:edit, :update, :destroy]

	def index
		@instructors = Instructor.order(:created_at).page(params[:page])
		policy_scope(@instructors)
	end

	def new
		@instructor = Instructor.new
		authorize @instructor
	end

	def create
		@instructor = Instructor.new(instructor_params)
		authorize @instructor
		if @instructor.save
			redirect_to edit_dashboard_instructor_path(@instructor), notice: "Instructor successfully created"
		else
			render :new, alert: 'Something went wrong'
		end
	end

	def edit
	end

	def update
		if @instructor.update(instructor_params)
			redirect_to edit_dashboard_instructor_path(@instructor), notice: "Instructor successfully updated"
		else
			render :edit, alert: 'Something went wrong'
		end
	end

	def destroy
		@instructor.destroy
		redirect_to dashboard_instructors_path, notice: "Instructor successfully deleted"
	end

	private

	def set_instructor
		@instructor = Instructor.find(params[:id])
		authorize @instructor
	end

	def instructor_params
		params.require(:instructor).permit(:first_name, :last_name, :bio, :photo)
	end
end