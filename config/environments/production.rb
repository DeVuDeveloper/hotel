# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do

  config.hosts << "hotel-poseidon.online"
  
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.public_file_server.enabled = true

  config.assets.compile = false

  config.active_storage.service = :cloudinary

  config.log_level = :info

  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.report_deprecations = false

  config.log_formatter = ::Logger::Formatter.new

  config.logger = Logger.new(STDOUT)

  config.logger = Logger.new("#{Rails.root}/log/production.log")

  config.active_record.dump_schema_after_migration = false

  config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }

  config.active_job.queue_adapter = :sidekiq

  config.factory_bot.definition_file_paths = [Rails.root.join('spec', 'factories')]

  config.factory_bot.reload

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  address: 'smtp.sparkpostmail.com',
  port: 587,
  domain: 'hotel-ocean.online',
  user_name: ENV['SPARKPOST_SMTP_USERNAME'],
  password: ENV['SPARKPOST_API_KEY'],
  authentication: :login,
  enable_starttls_auto: true
}
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
end
