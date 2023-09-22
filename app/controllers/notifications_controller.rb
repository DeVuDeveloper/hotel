class NotificationsController < ApplicationController
  def index
    @notifications = Notification.includes([:recipient]).where(recipient: current_user)
     @notifications.mark_as_read!
  end
end