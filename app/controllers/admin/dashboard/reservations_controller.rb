class Admin::Dashboard::ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_reservation_and_room, only: [:edit, :update, :destroy]

  layout "admin"

  def index
    @reservations = Reservation.all
    @page_title = "Reservations"
  end
  
    def edit
    end
  
    def update
      if @reservation.update(reservation_params)
        redirect_to admin_dashboard_reservations_path, notice: 'Reservation was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
        @reservation.destroy
        respond_to do |format|
        format.html { redirect_to admin_dashboard_hotel_reservations_path, notice: "Reservations was successfully destroyed." }
        format.turbo_stream { flash.now[:notice] = "Reservations was successfully destroyed." }
      end
    end
  
    private
  
    def set_reservation_and_room
      @reservation = Reservation.find(params[:id])
      @room = @reservation.room
    end
  
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :number_of_guests, :total_price, :status, :user_id)
    end

    def authorize_admin!
      unless current_user.is_admin? || current_user.super_admin?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end
  
