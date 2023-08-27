class CalendarEntry < ApplicationRecord
    belongs_to :calendar
  
    validates :date, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :available, inclusion: { in: [true, false] }
  
    def season_name(month)
      case month
      when 6..8
        "Summer"
      when 12, 1, 2
        "Winter"
      when 3..5
        "Spring"
      else
        "Autumn"
      end
    end
  
    def availability_data
      current_season_price = price
      bg_color = available ? "green" : "red"
        
      {
        title: available ? "Available" : "Booked",
        start: date,
        backgroundColor: bg_color,
        price: available ? current_season_price : '--',
        season: season_name(date.month),
      }
    end
  end
  