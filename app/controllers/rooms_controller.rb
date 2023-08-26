class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all.paginate(page: params[:page], per_page: 2)
  end

  def show
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
