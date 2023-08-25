class CalendarsController < ApplicationController
  before_action :set_room

  def index
    @calendars = @room.calendars
    @rooms = Room.all
  end

  def new
    @calendar = @room.calendars.new
  end

  def create
    @calendar = @room.calendars.new(calendar_params)
    if @calendar.save!
      redirect_to room_calendars_path(@room), notice: "Calendar entry was successfully created."
    else
      render :new
    end
  end

  def availability
    @room = Room.find(params[:room_id])
    availability_data = @room.availability_data
    render json: availability_data
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def calendar_params
    params.require(:calendar).permit(:date, :price, :available)
  end
end

