class UserMailer < ApplicationMailer
  def contact(contact)
    mail(from: "mail_sender@gmail.com", to: contact.email, body: contact.text, subject: "Email from User")
  end

  def send_reminder_email(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: "Vaš boravak u hotelu se približava")
  end
end
