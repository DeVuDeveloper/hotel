# frozen_string_literal: true

module Admin
  module Dashboard
    class UserMessagesController < ApplicationController
      layout "admin"
      before_action :authenticate_user!
      before_action :set_user_message, only: %i[destroy show]

      def index
        @user_messages = UserMessage.includes(:user).all
        @page_title = "Tickets"
      end

      def show
        @page_title = "Ticket Details"
      end

      def destroy
        @user_message.destroy
        respond_to do |format|
          format.html { redirect_to admin_dashboard_hotels_path, notice: "Ticket was successfully destroyed." }
          format.turbo_stream { flash.now[:notice] = "Ticket was successfully destroyed." }
        end
      end

      private

      def set_user_message
        @user_message = UserMessage.find(params[:id])
      end
    end
  end
end
