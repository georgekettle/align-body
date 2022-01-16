class DashboardsController < ApplicationController
  def dashboard
    authorize(:dashboard)
  end
end
