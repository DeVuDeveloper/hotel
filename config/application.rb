require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module HotelApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets")
    config.assets.precompile += %w[application.css]
    config.autoload_paths += %W[#{config.root}/app/services]
  end
end
