class NotificationMessage < ApplicationRecord
  belongs_to :user
  has_noticed_notifications

  validates :content, presence: true

  after_create_commit :notify_user

  after_create_commit -> { broadcast_prepend_to "notification_messages", partial: "admin/dashboard/notification_messages/notification_message", locals: {notification_message: self}, target: "notification_messages" }

  def notify_user
    MessageNotification.with(notification_message: self).deliver_later(user)
  end
  def read
    message_notification = MessageNotification.find_by(notification_message: self)
    if message_notification && message_notification.read_at.present?
      return message_notification.read_at
    else
      return nil
    end
  end
end
