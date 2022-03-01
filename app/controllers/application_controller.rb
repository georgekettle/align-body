class ApplicationController < ActionController::Base
	include Authenticatable
  include Authorizable

  before_action :set_native_cookie
  before_action :hide_footer

  private

  def hide_footer
    @hide_footer = devise_controller?
  end

  def set_native_cookie
  	if params[:is_native] && cookies[:is_native].nil?
  		cookies[:is_native] = params[:is_native]
  	end
  end
end
