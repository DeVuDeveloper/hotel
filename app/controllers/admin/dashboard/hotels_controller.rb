class Admin::Dashboard::HotelsController < ApplicationController
    layout "admin"
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @hotels = Hotel.all
    @page_title = "Hotel"
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      redirect_to admin_dashboard_hotels_path, notice: "Hotel was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @hotel = Hotel.find(params[:id])
  end

  def update
    @hotel = Hotel.find(params[:id])
    if params[:hotel][:images]
      images = @hotel.images

      new_images = params[:hotel][:images].map { |img| img.is_a?(String) ? nil : img }
      images.attach(new_images.compact) if new_images.any?
    end
    @hotel.name = params[:hotel][:name]
  
    if @hotel.save
      redirect_to admin_dashboard_hotels_path, notice: "Hotel was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy
    redirect_to admin_dashboard_hotels_path, notice: "Hotel was successfully deleted."
  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :address, :description, :contact, images: [])
  end

  def authorize_admin!
    unless current_user.is_admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
