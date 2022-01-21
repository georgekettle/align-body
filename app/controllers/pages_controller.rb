class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def home
    @navbar_fixed = true
    flash[:notice] = "Notice"
    flash[:alert] = "alert"
  end

  def contact
  end
end
