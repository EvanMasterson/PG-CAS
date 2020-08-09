class DashboardController < ApplicationController
  include Secured

	def show
		@user_details = session[:userinfo]
		@user_id = current_user.select(:id).first.id
		@auth0_user_id = current_user.select(:auth0_user_id).first.auth0_user_id
		@bearer_token = @user_details['credentials']['id_token']
	  	@email = current_user.select(:email).first.email
	  	@country = current_user.select(:country).first.country
	  	@pre_existing_conditions = current_user.select(:pre_existing_conditions).first.pre_existing_conditions
	end
end