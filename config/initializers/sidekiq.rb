host = Rails.env.production? ? Rails.application.credentials.dig(:aws, :redis_hostname) : "127.0.0.1"
port = Rails.application.credentials.dig(:aws, :redis_port)

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:#{port}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{host}:#{port}/0" }
end