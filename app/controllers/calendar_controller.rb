class CalendarsController < ApplicationController
  before_action :set_room, only: [:index, :new, :create]

  def index
    @calendars = @room.calendars.order(:date)
  end

  def new
    @calendar = @room.calendars.new
  end

  def create
    @calendar = @room.calendars.new(calendar_params)

    if @calendar.save
      redirect_to room_calendars_path(@room), notice: "Calendar entry was successfully created."
    else
      render :new
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def calendar_params
    params.require(:calendar).permit(:date, :price, :available)
  end
end
