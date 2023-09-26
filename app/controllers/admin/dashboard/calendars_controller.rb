# frozen_string_literal: true

module Admin
  module Dashboard
    class CalendarsController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_admin!
      before_action :set_hotel, only: %i[index new create edit destroy]
      before_action :set_room, only: %i[index new create edit destroy]
      before_action :set_calendar, only: %i[edit update destroy]

      layout "admin"

      def index
        @calendars = Calendar.includes(:room).all if @hotel
        @page_title = "Calendars"
      end

      def new
        @calendar = @room.build_calendar
      end

      def create
        @calendar = @room.build_calendar(calendar_params)
        if @calendar.save
          respond_to do |format|
            format.html { redirect_to admin_dashboard_hotel_rooms_path, notice: "Calendar was successfully created." }
            format.turbo_stream { flash.now[:notice] = "Calendar was successfully created." }
          end
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
      end

      def update
        if @calendar.update(calendar_params)
          respond_to do |format|
            format.html do
              redirect_to admin_dashboard_hotel_calendars_path, notice: "Calendar was successfully updated."
            end
            format.turbo_stream { flash.now[:notice] = "Calendar was successfully updated." }
          end
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @calendar.destroy
        respond_to do |format|
          format.html do
            redirect_to admin_dashboard_hotel_calendars_path, notice: "Calendar was successfully destroyed."
          end
          format.turbo_stream { flash.now[:notice] = "Calendar was successfully destroyed." }
        end
      end

      private

      def set_hotel
        @hotel = Hotel.find_by(id: params[:hotel_id])
        redirect_to admin_dashboard_hotels_path, alert: "Hotel not found." unless @hotel
      end

      def set_room
        @hotel = Hotel.find_by(id: params[:hotel_id])
        @room = @hotel.rooms.find_by(id: params[:id])
      end

      def set_calendar
        @calendar = Calendar.find(params[:id])
      end

      def authorize_admin!
        return if current_user.is_admin? || current_user.super_admin?

        redirect_to root_path, alert: "You are not authorized to access this page."
      end

      def calendar_params
        params.require(:calendar).permit(:date, :price, :available, :room_id)
      end
    end
  end
end
