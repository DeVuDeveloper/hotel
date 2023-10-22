class ApiController < ApplicationController
  def send_location
    latitude = params[:latitude]
    longitude = params[:longitude]
    user_id = params[:user_id]

    user = current_user

    user.update(latitude: latitude, longitude: longitude)

    render json: {message: "Location data sucessfully saved"}
  end
end
