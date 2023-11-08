# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy like]
  before_action :authenticate_user!, only: [:like]

  def index
    @user = current_user
    all_rooms = Room.includes(image_attachment: :blob).all
    Rails.logger.debug(all_rooms.to_sql)
    @rooms = all_rooms.paginate(page: params[:page], per_page: 2)

    Rails.cache.fetch("all_rooms", expires_in: 1.hour) do
      all_rooms
    end

    @room_reservations = get_room_reservations(@rooms)
  end

  def show
  end

  def like
    existing_like = @room.likes.find_by(user_id: current_user.id)

    if existing_like
      existing_like.destroy
      notice = "You unliked this room."
    else
      like = @room.likes.new(user_id: current_user.id, like: true)
      notice = if like.save
        "You liked this room."
      else
        "Failed to like this room."
      end
    end

    respond_to do |format|
      format.html { redirect_to rooms_path, notice: notice }
      format.turbo_stream { flash.now[:notice] = notice }
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def get_room_reservations(rooms)
    return unless current_user
    reservations = current_user.reservations.where(room_id: rooms.pluck(:id))
    reservations.group_by(&:room_id)
  end
end
