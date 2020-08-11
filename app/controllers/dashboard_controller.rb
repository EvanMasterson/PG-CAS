class DashboardController < ApplicationController
	include Secured
  	before_action :current_user

	def show
		# current_user
		@user_details = @current_user
		@user_id = @current_user.id
		@auth0_user_id = @current_user.auth0_user_id
		@bearer_token = "Need to add this to user model"
		@email = @current_user.email
		@country = @current_user.country
		@pre_existing_conditions = @current_user.pre_existing_conditions
	end
end