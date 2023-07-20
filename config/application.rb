require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Hotel
  class Application < Rails::Application
    config.load_defaults 7.0
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets")
    config.assets.precompile += %w[application.css]
  end
end
