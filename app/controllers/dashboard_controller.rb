class DashboardController < ApplicationController
  def dashboard
    authorize(:dashboard)
  end
end
