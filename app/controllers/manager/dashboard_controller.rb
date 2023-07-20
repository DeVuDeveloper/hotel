class Manager::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_manager!
  
    def index
      
    end
  
    private
  
    def authorize_manager!
      unless current_user.is_manager?
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end