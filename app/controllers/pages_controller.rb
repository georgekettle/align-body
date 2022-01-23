class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def home
    @navbar_fixed = true
  end

  def contact
  end

  def help
  end
end
