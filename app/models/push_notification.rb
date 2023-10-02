# frozen_string_literal: true

class PushNotification < ApplicationRecord
  after_create_commit lambda {
                        broadcast_prepend_to "push_notifications", partial: "admin/dashboard/push_notifications/push_notification",
                          locals: {push_notification: self}, target: "push_notifications"
                      }
end
