# frozen_string_literal: true

class SendReminderEmailJob < SidekiqJob
  def perform(reservation_id)
    reservation = Reservation.find(reservation_id)

    UserMailer.send_reminder_email(reservation).deliver_now
  end
end
