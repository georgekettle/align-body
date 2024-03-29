module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
		before_action :configure_permitted_parameters, if: :devise_controller?
  end

  private

  def configure_permitted_parameters
  	added_attrs = %i[first_name last_name email password password_confirmation phone terms_of_service]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end
end