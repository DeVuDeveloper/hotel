class Admin::HotelsController < ApplicationController
    layout 'admin'
    before_action :authenticate_user!
    before_action :authorize_admin!
  
    def index
      @hotels = Hotel.all
    end
  
    def new
      @hotel = Hotel.new
    end
  
    def create
      @hotel = Hotel.new(hotel_params)
      if @hotel.save
        redirect_to admin_hotels_path, notice: "Hotel was successfully created."
      else
        render :new
      end
    end
  
    def edit
      @hotel = Hotel.find(params[:id])
    end
  
    def update
      @hotel = Hotel.find(params[:id])
      if @hotel.update(hotel_params)
        redirect_to admin_hotels_path, notice: "Hotel was successfully updated."
      else
        render :edit
      end
    end
  
    def destroy
      @hotel = Hotel.find(params[:id])
      @hotel.destroy
      redirect_to admin_hotels_path, notice: "Hotel was successfully deleted."
    end
  
    private
  
    def hotel_params
      params.require(:hotel).permit(:name, :address, :description, :contact, :image)
    end
  
    def authorize_admin!
      unless current_user.is_admin?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end