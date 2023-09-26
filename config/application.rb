# frozen_string_literal: true

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module HotelApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets")
    config.assets.precompile += %w[application.css]
    config.autoload_paths += %W[#{config.root}/app/services]
    config.action_controller.forgery_protection_origin_check = false
    config.cache_store = :redis_cache_store, {url: "redis://localhost:6379/0"}
    config.log_level = :debug
    config.vapid_public_key = "BHphE0pZSfXzTmpGq0fm0tiBqae266QYhqs8lF4z1IabrP33GywDyALSefRuiWUOEMCcZdKnuaHDK839uVstA4M"
    config.vapid_private_key = "NCG4tTOZZlyFOEAcySzR6-I5CxqyjVn-g3Y7zTMDDEw"
  end
end
