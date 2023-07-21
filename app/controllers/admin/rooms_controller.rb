class Admin::RoomsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    layout 'admin'
    
    def index
      @rooms = Room.all
    end
  
    def new
      @room = Room.new
    end
  
    def create
      @room = Room.new(room_params)
      if @room.save
        redirect_to admin_rooms_path, notice: "Room was successfully created."
      else
        render :new
      end
    end
  
    def edit
      @room = Room.find(params[:id])
    end
  
    def update
      @room = Room.find(params[:id])
      if @room.update(room_params)
        redirect_to admin_rooms_path, notice: "Room was successfully updated."
      else
        render :edit
      end
    end
  
    def destroy
      @room = Room.find(params[:id])
      @room.destroy
      redirect_to admin_rooms_path, notice: "Room was successfully deleted."
    end
  
    private
  
    def room_params
      params.require(:room).permit(:name, :room_type, :number_of_beds, :price_per_night, :description)
    end
  
    def authorize_admin!
        unless current_user.is_admin? || current_user.is_superadmin?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end
  