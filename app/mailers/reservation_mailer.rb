class ReservationMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def confirmation_email(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: "Potvrdite svoju rezervaciju")
  end
end
