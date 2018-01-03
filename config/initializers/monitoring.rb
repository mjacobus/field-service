Raven.configure do |config|
  config.dsn = ENV.fetch('RAVEN_DSN')
end
