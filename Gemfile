# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem "devise", "~> 4.9", ">= 4.9.2"
gem "htmlbeautifier"
gem "momentjs-rails"
gem "noticed", "~> 1.6"
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.6"
gem "redis", "~> 4.0"
gem "rufo"
gem "elasticsearch-model"
gem "serviceworker-rails"
gem "sidekiq"
gem "sidekiq-scheduler"
gem "simple_form", "~> 5.1.0"
gem "propshaft"
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "view_component"
gem "web-push"
gem "will_paginate", "~> 4.0"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
  gem "rspec-rails"
end

group :development do
  gem "bullet"
  gem "letter_opener"
  gem "standard"
  gem "web-console"
end

group :test do
  gem "capybara", "~> 3.35", ">= 3.35.3"
  gem "selenium-webdriver"
  gem "webdrivers"
end
