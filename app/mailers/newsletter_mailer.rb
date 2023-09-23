class NewsletterMailer < ApplicationMailer
  def send_newsletter(user, newsletter)
    @user = user
    @newsletter = newsletter
    mail(to: @user.email, subject: @newsletter.subject) do |format|
      format.text { render plain: @newsletter.content }
      format.html { render html: @newsletter.content }
    end
  end
end
