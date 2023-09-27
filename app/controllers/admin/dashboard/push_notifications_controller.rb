# frozen_string_literal: true

module Admin
  module Dashboard
    class PushNotificationsController < ApplicationController
      layout "admin"
      before_action :authenticate_user!, except: [:subscribe]
      before_action :authorize_admin!, except: [:subscribe]
      before_action :set_push_notification, only: %i[show edit update destroy]

      def index
        @push_notifications = PushNotification.all
        @page_title = "Push Notifications"
      end

      def show
        @page_title = "Push Notification Details"
      end

      def new
        @push_notification = PushNotification.new
      end

      def create
        @push_notification = PushNotification.new(push_notification_params)

        if @push_notification.save
          send_push_notification(@push_notification)
          respond_to do |format|
            format.html do
              redirect_to admin_dashboard_push_notifications_path, notice: "Push Notification was successfully created"
            end
            format.turbo_stream { flash.now[:notice] = "Push Notification was successfully created" }
          end
        else
          render :new, status: :unprocessable_entity
        end
      end

      def destroy
        @push_notification.destroy
        respond_to do |format|
          format.html do
            redirect_to admin_dashboard_push_notifications_path, notice: "Push Notification was successfully destroyed."
          end
          format.turbo_stream { flash.now[:notice] = "Push Notification was successfully destroyed." }
        end
      end

      def subscribe
        subscription = PushSubscription.new(
          endpoint: params[:endpoint],
          p256dh: params[:p256dh],
          auth: params[:auth],
          subscribed: true,
        )

        if subscription.save
          render json: { message: "Subscription successfully saved" }, status: :ok
        else
          render json: { error: "Error in storing subscription" }, status: :unprocessable_entity
        end
      end

      private

      def set_push_notification
        @push_notification = PushNotification.find(params[:id])
      end

      def push_notification_params
        params.require(:push_notification).permit(:title, :body)
      end

      def send_push_notification(push_notification)
        subscriptions = PushSubscription.where(subscribed: true)
        icon_url = ActionController::Base.helpers.image_url("note.jpg")

        message = {
          title: push_notification.title,
          body: push_notification.body,
          icon: icon_url,
        }

        vapid_details = {
          subject: "mailto:#{ENV["DEFAULT_EMAIL"]}",
          public_key: ENV["DEFAULT_APPLICATION_SERVER_KEY"],
          private_key: ENV["DEFAULT_PRIVATE_KEY"],
        }

        subscriptions.each do |subscription|
          WebPush.payload_send(
            message: JSON.generate(message),
            endpoint: subscription.endpoint,
            p256dh: subscription.p256dh,
            auth: subscription.auth,
            vapid: vapid_details,
          )
        end

        respond_to do |format|
          format.html do
            redirect_to admin_dashboard_push_notifications_path, notice: "Push Notification was successfully sent"
          end
          format.turbo_stream { flash.now[:notice] = "Push Notification was successfully sent" }
        end
      end

      def authorize_admin!
        return if current_user.is_admin? || current_user.super_admin?

        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end
end
