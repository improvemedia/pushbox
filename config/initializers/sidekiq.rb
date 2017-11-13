
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['PB_SIDEKIQ_REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['PB_SIDEKIQ_REDIS_URL'] }
end
