# frozen_string_literal: true

class Calendar < ApplicationRecord
  belongs_to :room
  has_many :calendar_entries, dependent: :destroy

  validates :room, presence: true

  after_create_commit lambda {
                        broadcast_prepend_to "calendars", partial: "admin/dashboard/calendars/calendar", locals: {calendar: self},
                          target: "calendars"
                      }

  def generate_default_entries
    calendar_entries.find_or_create_by do |entry|
      entry.date = date
      entry.price = calculate_seasonal_price(date)
      entry.available = true
    end
  end

  private

  def calculate_seasonal_price(date)
    case date.month
    when 6..8
      room.summer_price
    when 12, 1, 2
      room.winter_price
    when 3..5
      room.spring_price
    else
      room.autumn_price
    end
  end
end
