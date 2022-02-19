class ApplicationController < ActionController::Base
	include Authenticatable
  include Authorizable

  before_action :set_native_cookie
  before_action :redirect_coming_soon

  private

  def set_native_cookie
  	if params[:is_native] && cookies[:is_native].nil?
  		cookies[:is_native] = params[:is_native]
  	end
  end

  def redirect_coming_soon
    unless ['coming_soon', 'sessions'].include?(controller_name)
      # flash[:notice] = "We are launching soon! ✨"
      redirect_to new_coming_soon_path
    end
  end
end
