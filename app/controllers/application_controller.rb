class ApplicationController < ActionController::Base
	include Authenticatable
  include Authorizable
end
