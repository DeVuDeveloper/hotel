class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all.paginate(page: params[:page], per_page: 2)
    @room_reservations = get_room_reservations(@rooms)
  end

  def show
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def get_room_reservations(rooms)
    reservations = current_user.reservations.where(room_id: rooms.pluck(:id))
    reservations.group_by(&:room_id)
  end
end
