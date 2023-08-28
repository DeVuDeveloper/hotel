class CalendarEntriesController < ApplicationController
  before_action :set_calendar_entries

  def index
    events = @calendar_entries.map do |entry|
      {
        title: entry.availability_data[:title],
        start: entry.availability_data[:start],
        backgroundColor: entry.availability_data[:backgroundColor],
        price: entry.availability_data[:price],
        season: entry.availability_data[:season]
      }
    end

    render json: events
  end

  private

  def set_calendar_entries
    @calendar_entries = CalendarEntry.where(calendar_id: params[:calendar_id])
  end
end
