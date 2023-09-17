class HotelComponent < ViewComponent::Base
  include Turbo::FramesHelper
  
  def initialize(hotel:, reviews:)
    @hotel = hotel
    @reviews = reviews
  end
end
