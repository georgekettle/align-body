class Dashboard::UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :destroy]

	def index
		@users = User.order(:created_at).page(params[:page])
		policy_scope(@users)
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to edit_dashboard_user_path(@user), notice: "User successfully updated"
		else
			render :edit, alert: 'Something went wrong'
		end
	end

	def destroy
		@user.destroy
		redirect_to dashboard_users_path, notice: "User successfully deleted"
	end

	private

	def set_user
		@user = User.find(params[:id])
		authorize @user
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :admin, :phone, :spotify_hash)
	end
end