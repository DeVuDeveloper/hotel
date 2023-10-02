# frozen_string_literal: true

module Admin
  class RoomFormComponent < ViewComponent::Base
    def initialize(hotel:, room:)
      @hotel = hotel
      @room = room
    end
  end
end
