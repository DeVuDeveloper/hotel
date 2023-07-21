class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  layout "admin"

  def index
  end

  private

  def authorize_admin!
    unless current_user.is_admin? || current_user.is_superadmin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
