class ComingSoonController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :hide_all_navbars

	def new
	end

	def create
		@client = Airtable::Client.new(ENV['AIRTABLE_API_KEY'])
		@record = Airtable::Record.new(
									first_name: user_params[:first_name],
									last_name: user_params[:last_name],
									email: user_params[:email])
		table_key = "tblpBydQvolIGRBY7"
		app_key = "applUN1BYlmu0Nsx6"
		@table = @client.table(app_key, table_key)
		if verify_recaptcha && @table.create(@record)
			redirect_to new_coming_soon_path, notice: "Thanks for signing up girlfriend ✨ We will be in touch soon!"
		else
			redirect_to new_coming_soon_path, notice: "Something went wrong, please try again..."
		end
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email)
	end

	def hide_all_navbars
		@navbar_fixed = true
		@hide_web_navbar = true
		@hide_native_navbar = true
	end
end
