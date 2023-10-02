# frozen_string_literal: true

module Admin
  class HotelFormComponent < ViewComponent::Base
    def initialize(hotel:)
      @hotel = hotel
    end
  end
end
