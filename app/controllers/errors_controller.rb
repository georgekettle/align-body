class ErrorsController < ApplicationController
  before_action :hide_footer

  def not_found
    render(:status => 404)
  end

  def internal_server_error
    render(:status => 500)
  end

  private

  def hide_footer
    @hide_footer = true
  end
end
