# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.6"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "bootsnap", require: false
gem "vite_rails"
gem "vite_ruby"
gem "simple_form", "~> 5.1.0"
gem "view_component"
gem "rufo"
gem "htmlbeautifier"
gem "devise", "~> 4.9", ">= 4.9.2"
gem "momentjs-rails"
gem "importmap-rails"
gem "will_paginate", "~> 4.0"
gem "sidekiq"
gem "sidekiq-scheduler"

gem 'actionpack-action_caching'


group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
end

group :development do
  gem "standard"
  gem "web-console"
  gem "letter_opener"
  gem 'bullet'
end

group :test do
  gem "capybara", "~> 3.35", ">= 3.35.3"
  gem "selenium-webdriver"
  gem "webdrivers"
end
