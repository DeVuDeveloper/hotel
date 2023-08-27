class SeasonalPriceComponent < ViewComponent::Base
  def initialize(room)
    @room = room
    @seasonal_price = room.calculate_seasonal_price(Date.today)
  end

  def call
    @seasonal_price
  end
end