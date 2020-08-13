class Auth0Controller < ApplicationController
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']
    @authorization = Authorization.find_by_provider_and_uid(session[:userinfo]["provider"], session[:userinfo]["uid"])
    if @authorization
      # Update token if user already exists
      user = User.find_by(:auth0_user_id => session[:userinfo]['uid'])
      user.update(bearer_token: session[:userinfo]['credentials']['token'])
    else
      puts "new user"
      user = User.new(
        :name =>  session[:userinfo]['extra']['raw_info']['name'], 
        :email =>  session[:userinfo]['extra']['raw_info']['email'], 
        :auth0_user_id =>  session[:userinfo]['uid'],
        :bearer_token => session[:userinfo]['credentials']['token'],
        :profile_photo_url =>  session[:userinfo]['info']['image'])
      user.authorizations.build :provider =>  session[:userinfo]["provider"], :uid =>  session[:userinfo]["uid"]
      user.save
    end
  # Redirect to the URL you want after successful auth
  # redirect_to '/dashboard', notice: "Successfully logged in" #secured doesn't pick up that a revisiting user has session[:userinfo] - why?
  redirect_to dashboard_path
  end  

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end
end