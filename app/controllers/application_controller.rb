class ApplicationController < ActionController::Base
	include Authenticatable
  include Authorizable

  before_action :set_native_cookie

  private

  def set_native_cookie
  	if params[:is_native] && cookies[:is_native].nil?
  		cookies[:is_native] = params[:is_native]
  	end
  end
end
