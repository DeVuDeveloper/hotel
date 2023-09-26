# frozen_string_literal: true

class HotelsController < ApplicationController
  def index
    @user = current_user
    @hotels = Hotel.includes(images_attachments: :blob).all
    @hotel = Hotel.first
    @reviews = Review.includes(:user).all
    @average_rating = RatingCalculatorService.calculate_average_rating(@reviews)
    session[:cookies_accepted] = nil
    respond_to do |format|
      format.html
      format.json { render json: @hotels }
    end
  end

  def contact_new
    @contact_form = if current_user
      ContactForm.new(
        email: current_user.email
      )
    else
      ContactForm.new
    end
  end

  def contact_create
    @contact_form = ContactForm.new(contact_form_params)
    if @contact_form.save
      UserMailer.contact(@contact_form).deliver
      flash.now[:notice] = "Your email is sent"
      @contact_form.text = ""
    end
    render :contact_new
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(
      *ContactForm::FIELDS
    )
  end
end
