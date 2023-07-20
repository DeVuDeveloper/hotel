class Admins::SessionsController < Devise::SessionsController
  layout 'admin_login'

  def create
    # Add the following line to specify the Devise mapping explicitly
    @request.env["devise.mapping"] = Devise.mappings[:user]

    user = User.find_by(email: params[:user][:email])
    if user && user.is_admin? && user.valid_password?(params[:user][:password])
      sign_in user
      redirect_to admin_dashboard_path 
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end
end
