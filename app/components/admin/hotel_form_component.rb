class Admin::HotelFormComponent < ViewComponent::Base
  def initialize(hotel:)
    @hotel = hotel
  end
end
