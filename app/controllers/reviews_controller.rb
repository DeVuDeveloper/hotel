# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hotel
  before_action :set_review, only: %i[edit update destroy]

  def new
    @review = @hotel.reviews.build
  end

  def create
    @review = @hotel.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Review was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Review was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    puts "Params: #{params.inspect}"
    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to reviews_path, notice: "Review was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Review was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @review.destroy
      respond_to do |format|
        format.html { redirect_to reviews_path, notice: "Review was successfully destroyed." }
        format.turbo_stream { flash.now[:notice] = "Review was successfully destroyed." }
      end
    else
      respond_to do |format|
        format.html { redirect_to reviews_path, alert: "Failed to destroy the review." }
        format.turbo_stream { flash.now[:alert] = "Failed to destroy the review." }
      end
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :hotel_id, :user_id)
  end
end
