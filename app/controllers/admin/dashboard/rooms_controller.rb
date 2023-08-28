class Admin::Dashboard::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_hotel, only: [:index, :new, :create, :edit, :edit_seasonal_prices, :update_seasonal_prices]
  before_action :set_room, only: [:edit, :update, :destroy, :edit_seasonal_prices, :update_seasonal_prices, :generate_calendars]

  layout "admin"

  def index
    if @hotel
      @rooms = @hotel.rooms.ordered
    end
    @page_title = "Rooms"
  end

  def show
    @hotel = Hotel.find_by(id: params[:hotel_id])
    @room = @hotel.rooms.find_by(id: params[:id])
  end

  def new
    @room = @hotel.rooms.build
  end

  def create
    @hotel = Hotel.first
    @room = @hotel.rooms.build(room_params)

    if @room.save
      respond_to do |format|
        format.html { redirect_to admin_dashboard_hotel_rooms_path, notice: "Room was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Room was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      respond_to do |format|
        format.html { redirect_to admin_dashboard_hotel_rooms_path, notice: "Room was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Room was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_hotel_rooms_path, notice: "Room was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Room was successfully destroyed." }
    end
  end

  def edit_seasonal_prices
  end

  def update_seasonal_prices
    if @room.update(seasonal_prices_params)
      respond_to do |format|
        format.html { redirect_to admin_dashboard_hotel_rooms_path, notice: "Seasonal prices were successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Seasonal prices were successfully updated." }
      end
    else
      render :edit_seasonal_prices, status: :unprocessable_entity
    end
  end

  def generate_calendars
    room = Room.find(params[:room_id])
    room.generate_calendar_entries_for_seasonal_prices

    respond_to do |format|
      format.html { redirect_to admin_dashboard_hotel_rooms_path, notice: "Calendar entries were successfully updated." }
      format.turbo_stream { flash.now[:notice] = "Calendar entries were successfully updated." }
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find_by(id: params[:hotel_id])
    redirect_to admin_dashboard_hotels_path, alert: "Hotel not found." unless @hotel
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def authorize_admin!
    unless current_user.is_admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def seasonal_prices_params
    params.require(:room).permit(:summer_price, :winter_price, :spring_price, :autumn_price)
  end

  def room_params
    params.require(:room).permit(:name, :room_type, :number_of_beds, :description, :image)
  end
end
