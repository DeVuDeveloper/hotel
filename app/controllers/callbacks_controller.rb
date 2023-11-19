class CallbacksController < ApplicationController
  before_action :validate_google_csrf, only: :google_onetap

  def google_onetap
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: ENV["GOOGLE_CLIENT_ID"])
    Rails.logger.debug("Google One Tap Payload: #{payload}")

    user = User.find_or_initialize_by(email: payload["email"])

    unless user.persisted?
      user.name = payload["name"]
      user.password = SecureRandom.hex(16)
      user.save!
    end

    sign_in(user)
    redirect_to root_path(locale: params[:locale])
  rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError => e
    Rails.logger.error("Authentication failed: #{e.message}")
    flash[:error] = "Authentication failed. Please try again."
    redirect_to root_path(locale: params[:locale])
  rescue StandardError => e
    Rails.logger.error("Unexpected error: #{e.message}")
    flash[:error] = "An unexpected error occurred. Please try again."
    redirect_to root_path(locale: params[:locale])
  end

  private

  def validate_google_csrf
    if cookies["g_csrf_token"].blank? ||
       params["g_csrf_token"].blank? ||
       cookies["g_csrf_token"] != params["g_csrf_token"]
      flash[:error] = "CSRF token mismatch. Please try again."
      redirect_to root_path(locale: params[:locale])
    end
  end
end
