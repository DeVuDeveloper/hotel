# frozen_string_literal: true

class PushSubscription < ApplicationRecord
  validates :endpoint, presence: true
  validates :p256dh, presence: true
  validates :auth, presence: true
  validates :subscribed, inclusion: {in: [true, false]}
end
