class ApplicationController < ActionController::Base
  include ControllerAuthentication
  helper :all

  protect_from_forgery



end
