class ApiController < ApplicationController
    def send_location
      latitude = params[:latitude]
      longitude = params[:longitude]
      user_id = params[:user_id]
  
      user = User.find(user_id)
  
      user.update(location_latitude: latitude, location_longitude: longitude)
  
      render json: { message: "Podaci o lokaciji su uspešno primljeni i obrađeni." }
    end
  end
  
  