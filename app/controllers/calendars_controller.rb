class CalendarsController < ApplicationController
  before_action :set_room
  
  def index
    @calendar = @room.calendar
    @rooms = Room.all
    entries = CalendarEntry.all
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

  def events
    room = Room.find(params[:room_id])
    entries = room.calendar_entries
    events = entries.map do |entry|
      {
        title: entry.available ? "Available" : "Booked",
        start: entry.date,
        backgroundColor: entry.background_color,
        price: entry.price
      }
    end

    render json: events
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def calendar_params
    params.require(:calendar).permit(:date, :price, :available)
  end
end
