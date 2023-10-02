# frozen_string_literal: true

module Admin
  module Dashboard
    class HotelsController < ApplicationController
      layout "admin"
      before_action :authenticate_user!
      before_action :authorize_admin!
      before_action :set_hotel, only: %i[edit update destroy]
      before_action :set_room, only: [:index]

      def index
        @hotels = Hotel.all
        @page_title = "Hotel"
        set_room
      end

      def new
        @hotel = Hotel.new
      end

      def create
        @hotel = Hotel.new(hotel_params)
        if @hotel.save
          respond_to do |format|
            format.html { redirect_to admin_dashboard_hotels_path, notice: "Hotel was successfully created." }
            format.turbo_stream { flash.now[:notice] = "Hotel was successfully created." }
          end
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
      end

      def update
        if params[:hotel][:images]
          images = @hotel.images

          new_images = params[:hotel][:images].map { |img| img.is_a?(String) ? nil : img }
          images.attach(new_images.compact) if new_images.any?
        end
        @hotel.name = params[:hotel][:name]

        if @hotel.update(hotel_params)
          respond_to do |format|
            format.html { redirect_to admin_dashboard_hotels_path, notice: "Hotel was successfully updated." }
            format.turbo_stream { flash.now[:notice] = "Hotel was successfully updated." }
          end
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @hotel.destroy
        respond_to do |format|
          format.html { redirect_to admin_dashboard_hotels_path, notice: "Hotel was successfully destroyed." }
          format.turbo_stream { flash.now[:notice] = "Hotel was successfully destroyed." }
        end
      end

      private

      def set_hotel
        @hotel = Hotel.find(params[:id])
        redirect_to admin_dashboard_hotels_path, alert: "Hotel not found." unless @hotel
      end

      def set_room
        @hotel = Hotel.find_by(params[:id])
        @room = @hotel.rooms.find_by(id: params[:hotel_id])
      end

      def hotel_params
        params.require(:hotel).permit(:name, :address, :description, :contact, images: [])
      end

      def authorize_admin!
        return if current_user.is_admin? || current_user.super_admin?

        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end
end
