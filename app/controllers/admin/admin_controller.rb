class Admin::AdminController < ApplicationController
    before_action :authenticate_user! 
    before_action :admin_only         
  
    private
  
    def admin_only
      unless current_user.admin?
        redirect_to root_path, alert: "Nemate pristup ovoj stranici."
      end
    end
end