class ComingSoonController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :hide_all_navbars

	def new
		create_validator()
	end

	def create
		@show_recaptcha = true
		create_validator(validator_params)
		create_table
		respond_to do |format|
			if @validator.valid? && verify_recaptcha(model: @validator) && @table.create(@record)
				format.html { redirect_to new_coming_soon_path, status: :see_other, notice: "Thanks for signing up girlfriend ✨ We will be in touch soon!" }
			else
				format.html { render :new, status: :unprocessable_entity }
			end
		end
	end

	private

	def validator_params
		params.require("Validator").permit(:first_name, :last_name, :email)
	end

	def create_validator(params={})
		@validator = Validator.make(
		  params,
		  {
		    :email => {:presence => true},
		    :first_name => {:presence => true},
		    :last_name => {:presence => true}
		  }
		)
	end

	def create_table
		client = Airtable::Client.new(ENV['AIRTABLE_API_KEY'])
		@record = Airtable::Record.new(
									first_name: validator_params[:first_name],
									last_name: validator_params[:last_name],
									email: validator_params[:email])
		table_key = "tblpBydQvolIGRBY7"
		app_key = "applUN1BYlmu0Nsx6"
		@table = client.table(app_key, table_key)
	end
	
	def hide_all_navbars
		@navbar_fixed = true
		@hide_web_navbar = true
		@hide_native_navbar = true
	end
end
