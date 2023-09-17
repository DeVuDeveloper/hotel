class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    all_rooms = Room.all
    @rooms = all_rooms.paginate(page: params[:page], per_page: 2)

    Rails.cache.fetch("all_rooms", expires_in: 1.hour) do
      all_rooms
    end
    @room_reservations = get_room_reservations(@rooms)
  end
  
 def show
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def get_room_reservations(rooms)
    if current_user
      reservations = current_user.reservations.where(room_id: rooms.pluck(:id))
      reservations.group_by(&:room_id)
    end
  end
end
