# frozen_string_literal: true

class SidekiqJob
  include Sidekiq::Worker

  def perform(*args)
  end
end
