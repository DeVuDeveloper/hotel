# frozen_string_literal: true

require_relative "boot"
require "rails/all"
# require "elasticsearch/model"

Bundler.require(*Rails.groups)

module HotelApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets")
    config.assets.precompile += %w[application.css]
    config.autoload_paths += %W[#{config.root}/app/services]
    config.action_controller.forgery_protection_origin_check = false
    config.log_level = :debug
    config.autoload_paths << Rails.root.join('lib')
    config.active_job.queue_adapter = :sidekiq
  end
end
