class SeasonalPriceComponent < ViewComponent::Base
    def initialize(room)
      @room = room
      @seasonal_price = room.calculate_seasonal_price(Date.today)
    end
  
    def call
      content_tag :div, class: 'seasonal-price' do
        "$#{@seasonal_price}"
      end
    end
  end