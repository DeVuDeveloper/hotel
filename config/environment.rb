# frozen_string_literal: true

# Load the Rails application.
require_relative "application"
require "will_paginate"
require 'sidekiq-scheduler'
# Initialize the Rails application.
Rails.application.initialize!
