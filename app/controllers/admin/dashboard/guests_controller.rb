class Admin::Dashboard::GuestsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_guest, only: %i[edit update destroy]

  def index
    @guests = User.where(role: "guest").includes(:reservations)
    @page_title = "Guests"
  end

  def show
  end

  def edit
  end

  def update
    if @guest.update(guest_params)
      flash.now[:notice] = "Guest was successfully updated."

      turbo_stream.update @guest
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @guest.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_guests_path, notice: "Guest was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Guest was successfully destroyed." }
    end
  end

  private

  def set_guest
    @guest = User.find(params[:id])
  end

  def guest_params
    params.require(:user).permit(:name, :id_card, :paid)
  end
end
