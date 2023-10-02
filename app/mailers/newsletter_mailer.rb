# frozen_string_literal: true

class NewsletterMailer < ApplicationMailer
  def send_newsletter(user, newsletter, unsubscribe_link)
    @user = user
    @newsletter = newsletter
    @unsubscribe_link = unsubscribe_link
    mail(to: user.email, subject: newsletter.subject, &:html)
  end
end
