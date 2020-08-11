module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/', notice: "Secured.rb: Redirecting to home screen because there is no current_user" unless session[:userinfo].present?
  end
end