class Admin::Dashboard::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_hotel, only: [:index, :new, :create, :edit]
  before_action :set_room, only: [:edit, :update, :destroy]

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

  private

  def room_params
    params.require(:room).permit(:name, :room_type, :number_of_beds, :price_per_night, :description, :image)
  end

  def set_hotel
    @hotel = Hotel.find_by(id: params[:hotel_id])
    redirect_to admin_dashboard_hotels_path, alert: "Hotel not found." unless @hotel
  end

  def set_room
    @hotel = Hotel.find_by(id: params[:hotel_id])
    @room = @hotel.rooms.find_by(id: params[:id])
    redirect_to admin_dashboard_hotel_rooms_path(@hotel), alert: "Room not found." unless @room
  end

  def authorize_admin!
    unless current_user.is_admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
