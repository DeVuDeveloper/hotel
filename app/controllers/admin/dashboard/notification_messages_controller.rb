class Admin::Dashboard::NotificationMessagesController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_notification_message, only: [:show, :edit, :update, :destroy]

  def index
    @notification_messages = NotificationMessage.includes(:user).all
    @page_title = "Notifications"
    @notification = current_user.notifications.find_by(params[:notification_message])
  end

  def show
    @page_title = "Notification Details"
  end

  def new
    @notification_message = NotificationMessage.new
  end

  def create
    @notification_message = NotificationMessage.new(notification_message_params)
    if @notification_message.save
      respond_to do |format|
        format.html { redirect_to admin_dashboard_notification_messages_path, notice: "Notification was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Notification was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @notification_message.update(notification_message_params)
      respond_to do |format|
        format.html { redirect_to admin_dashboard_notification_messagess_path, notice: "Notification was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Notification was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @notification_message.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_notification_messagess_path, notice: "Notification was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Notification was successfully destroyed." }
    end
  end

  private

  def set_notification_message
    @notification_message = NotificationMessage.find(params[:id])
  end

  def notification_message_params
    params.require(:notification_message).permit(:content, :user_id)
  end

  def authorize_admin!
    unless current_user.is_admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
