class Dashboard::CategoriesController < ApplicationController
	before_action :set_category, only: [:edit, :update, :destroy]

	def index
		@categories = Category.order(:created_at).page(params[:page])
		policy_scope(@categories)
	end

	def new
		@category = Category.new
		authorize @category
	end

	def create
		@category = Category.new(category_params)
		authorize @category
		if @category.save
			redirect_to edit_dashboard_category_path(@category), notice: "Category successfully created"
		else
			render :new, alert: 'Something went wrong'
		end
	end

	def edit
	end

	def update
		if @category.update(category_params)
			redirect_to edit_dashboard_category_path(@category), notice: "Category successfully updated"
		else
			render :edit, alert: 'Something went wrong'
		end
	end

	def destroy
		@category.destroy
		redirect_to dashboard_categories_path, notice: "Category successfully deleted"
	end

	private

	def set_category
		@category = Category.find(params[:id])
		authorize @category
	end

	def category_params
		params.require(:category).permit(:name, :description, :photo)
	end
end