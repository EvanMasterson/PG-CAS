class ApplicationController < ActionController::Base
  
  private

  def current_user
    @current_user ||= User.where(:auth0_user_id => session[:userinfo]['uid']) if session[:userinfo]['uid']
  end
  helper_method :current_user

  def current_user_details
	@user_details = session[:userinfo]
	@bearer_token = @user_details['credentials']['id_token']
	@user_id = current_user.select(:id).first.id
	@auth0_user_id = current_user.select(:auth0_user_id).first.auth0_user_id
  	@email = current_user.select(:email).first.email
  	@country = current_user.select(:country).first.country
  	@pre_existing_conditions = current_user.select(:pre_existing_conditions).first.pre_existing_conditions
  end
end
