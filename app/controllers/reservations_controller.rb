class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create, :edit, :update]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @room.reservations.new(reservation_params)
 
    price_calculator = PriceCalculatorService.new(@room, @reservation.start_date, @reservation.end_date, @reservation.number_of_guests)
    @reservation.total_price = price_calculator.call
    if @reservation.save
      ReservationMailer.confirmation_email(@reservation).deliver_now
      @reservation.dates.each do |date|
        calendar_entry = @room.calendar.calendar_entries.find_by(date: date)
        calendar_entry.update(available: false) if calendar_entry
      end
      
      redirect_to rooms_path, notice: "Reservation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    cancel
  end

  def cancel
  @reservation = Reservation.find(params[:id])
  @room = @reservation.room

  if @reservation.update(status: :cancelled)
    @reservation.dates.each do |date|
      calendar_entry = @room.calendar.calendar_entries.find_by(date: date)
      calendar_entry.update(available: true) if calendar_entry
    end

    redirect_to rooms_path, notice: "Reservation was successfully canceled."
  else
    redirect_to rooms_path, alert: "Failed to cancel reservation."
  end
end

def confirm
  @reservation = Reservation.find(params[:id])
  @reservation.generate_token

  if @reservation.update(status: :confirmed)
    redirect_to rooms_path, notice: 'Reservation was successfully confirmed'
  else
    redirect_to rooms_path, alert: 'There are some problems with confirming reservation.'
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
