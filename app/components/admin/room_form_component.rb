class Admin::RoomFormComponent < ViewComponent::Base
  def initialize(hotel:, room:)
    @hotel = hotel
    @room = room
  end
end
