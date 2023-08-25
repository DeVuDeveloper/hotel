class Calendar < ApplicationRecord
  belongs_to :room

  validates :date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :available, inclusion: { in: [true, false] }

  after_create_commit -> { broadcast_prepend_to "calendars", partial: "admin/dashboard/calendars/calendar", locals: {calendar: self}, target: "calendars" }

  def availability_data
    current_season_price = case date.month
                           when 6..8
                             room.summer_price
                           when 12, 1, 2
                             room.winter_price
                           when 3..5
                             room.spring_price
                           else
                             room.autumn_price
                           end

    {
      title: available ? "Available" : "Booked",
      start: date,
      price: available ? current_season_price : nil,
      backgroundColor: available ? "green" : "red",
    }
  end
end