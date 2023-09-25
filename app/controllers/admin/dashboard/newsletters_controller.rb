class Admin::Dashboard::NewslettersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:subscribe]
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy]

  def index
    @newsletters = Newsletter.all
    @page_title = "Newsletters"
  end

  def show
    @page_title = "Newsletter Details"
  end

  def new
    @selected_subscribers = User.where(subscribed: true)
    @newsletter = Newsletter.new
  end
  
  def create
    @newsletter = current_user.newsletters.build(newsletter_params)
    selected_subscribers = User.where(subscribed: true)
  
    if @newsletter.save
      selected_subscribers.each do |user|
        unsubscribe_link = unsubscribe_newsletter_url(user_id: user.id, token: user.unsubscribe_token)
        NewsletterMailer.send_newsletter(user, @newsletter, unsubscribe_link).deliver_now
      end
  
      respond_to do |format|
        format.html { redirect_to admin_dashboard_newsletters_path, notice: "Newsletter was successfully created and sent to subscribed users." }
        format.turbo_stream { flash.now[:notice] = "Newsletter was successfully created and sent to subscribed users." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def destroy
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_newsletters_path, notice: "Newsletter was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Newsletter was successfully destroyed." }
    end
  end
  

  def subscribe
    if current_user.update(subscribed: true, unsubscribe_token: SecureRandom.hex(20))
      render json: { subscribed: true }
    else
      render json: { error: "Subscription update failed" }, status: :unprocessable_entity
    end
  end

  def unsubscribe
    user_id = params[:user_id]
    token = params[:token]
  
    user = User.find_by(id: user_id)
  
    if user && user.unsubscribe_token == token
      user.update(subscribed: false) 
      flash[:notice] = "You have been successfully unsubscribed from our newsletters."
    else
      flash[:error] = "Invalid unsubscribe link. Please contact support for assistance."
    end
  
    redirect_to root_path
  end

  private

  def set_newsletter
    @newsletter = Newsletter.find(params[:id])
  end

  def newsletter_params
    params.require(:newsletter).permit(:subject)
  end

  def authorize_admin!
    unless current_user.is_admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
