class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :authorize_super_admin!

  def index
    @users = User.where.not(role: User.roles[:super_admin])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User was successfully created."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def authorize_super_admin!
    unless current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
