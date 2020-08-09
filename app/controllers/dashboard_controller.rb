class DashboardController < ApplicationController
  include Secured

	def show
		@user_details = session[:userinfo]
		binding.pry
	end
end