Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'JQ5uoA8wiuSsZ5Z34oddLSGb2dfn2sJ6',
    ENV['AUTH0_CLIENT_SECRET'],
    ENV['AUTH0_DOMAIN'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid email profile'
    }
  )
end
