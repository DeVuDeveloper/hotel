class ReservationsController < ApplicationController
  before_action :set_room

  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.new
  end

  def create
    @reservation = @room.reservations.new(reservation_params)
    
    price_calculator = PriceCalculatorService.new(@room, @reservation.start_date, @reservation.end_date, @reservation.number_of_guests)
    @reservation.total_price = price_calculator.call
  
    if @reservation.save
      @room.calendars.create(date: @reservation.start_date, available: false)
      redirect_to rooms_path, notice: "Reservation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :number_of_guests, :total_price, :status, :user_id)
  end
end
