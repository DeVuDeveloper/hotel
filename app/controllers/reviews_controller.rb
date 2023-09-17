class ReviewsController < ApplicationController
    before_action :find_hotel
  
    def new
      @review = @hotel.reviews.build
    end
  
    def create
      @review = @hotel.reviews.build(review_params)
      if @review.save
        redirect_to @hotel, notice: 'Review was successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def find_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end
  
    def review_params
      params.require(:review).permit(:rating, :comment, :hotel_id, :user_id)
    end
  end
  