class PriceCalculatorService
  def initialize(room, start_date, end_date, number_of_guests)
    @room = room
    @start_date = start_date
    @end_date = end_date
    @number_of_guests = number_of_guests
  end

  def call
    return calculate_total_price if all_fields_present?

    0.0
  end

  private

  attr_reader :room, :start_date, :end_date, :number_of_guests

  def all_fields_present?
    !room.nil? && start_date.present? && end_date.present? && number_of_guests.present?
  end

  def calculate_total_price
    room_price_per_night = room.price_per_night
    total_nights = (end_date - start_date).to_i + 1
    room_price_per_night * total_nights
  end
end
