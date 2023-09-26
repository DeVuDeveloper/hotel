# frozen_string_literal: true

class ChatbotController < ApplicationController
  def receive_message
    user_message = params[:message]
    bot_response, offer_support = process_user_message(user_message)
    user_email = current_user.email if user_signed_in?
    response_data = {bot_response:, user_email:, offer_support:}
    render json: response_data
  end

  def process_user_message(user_message)
    user_message = user_message.downcase

    return offer_support(user_message) unless user_message.start_with?("hello", "hi")
    return offer_support(user_message) if user_message.length > 5

    "Hello! Do you want to contact support team. Yes/No"
  end

  def offer_support(user_message)
    return "I'm sorry, you need to be signed in to request support. Please sign in to continue." unless user_signed_in?

    if user_message.downcase.include?("yes")
      "Please enter your email address for support."
    elsif user_message.downcase.include?("no")
      "Okay, thank you. Have a nice day!"
    elsif valid_email?(user_message)
      "Great! Please enter your question or issue."
    elsif user_message.downcase.include?(" ")
      current_user.user_messages.create(content: user_message) if user_signed_in?
      "Thank you for your question. You will be contacted via email shortly."
    else
      "I'm sorry, the email is not recognized. Enter a valid email address."
    end
  end

  def valid_email?(email)
    email.downcase.strip == current_user.email.downcase.strip
  end
end
