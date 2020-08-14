class ApplicationController < ActionController::Base
  include HTTParty
	attr_reader :current_user

  def current_user
    if session[:userinfo].present?
      @current_user ||= User.find_by(:auth0_user_id => session[:userinfo]['uid']) 
    else
      # redirect_to '/', notice: "Application controller: Can't set current user because we don't have the session info"
    end
  end
  helper_method :current_user

end
