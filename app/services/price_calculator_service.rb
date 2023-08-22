class PriceCalculatorService
  def initialize(room, start_date, end_date, number_of_guests)
    @room = room
    @start_date = start_date
    @end_date = end_date
    @number_of_guests = number_of_guests
  end

  def call
    calculate_total_price
  end

  private

  attr_reader :room, :start_date, :end_date, :number_of_guests

  def calculate_total_price
    room_price_per_night = room.price_per_night
    total_nights = (end_date - start_date).to_i + 1
    total_price = room_price_per_night * total_nights
    total_price
  end
end