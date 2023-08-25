class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all.paginate(page: params[:page], per_page: 2)
    @available_dates = Calendar.where(room_id: @rooms.pluck(:id), available: true).pluck(:date).uniq
  end

  def show
  end

  def availability
    room = Room.find(params[:id])
    availability_data = room.availability_data
    puts availability_data.inspect
    render json: availability_data
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
