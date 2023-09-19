class ChatbotController < ApplicationController

  def receive_message
    user_message = params[:message]
    bot_response, offer_support = process_user_message(user_message)
    user_email = current_user.email if user_signed_in?
    response_data = { bot_response: bot_response, user_email: user_email, offer_support: offer_support }
    render json: response_data
  end

  def process_user_message(user_message)
    user_message = user_message.downcase
  
    if user_message.start_with?("hello") || user_message.start_with?("hi")
      if user_message.length > 5 
        return offer_support(user_message)
      else
        return "Hello! Do you want to contact support team. Yes/No"
      end
    else
      return offer_support(user_message)
    end
  end
  
  def offer_support(user_message)
    if user_signed_in?
      if user_message.downcase.include?("yes")
        return "Please enter your email address for support."
      elsif user_message.downcase.include?("no")
        return "Okay, thank you. Have a nice day!"
      elsif valid_email?(user_message)
        return "Great! Please enter your question or issue."
      elsif user_message.downcase.include?(" ")
        if user_signed_in?
          current_user.user_messages.create(content: user_message)
        end
        return "Thank you for your question. You will be contacted via email shortly."
      else
        return "I'm sorry, the email is not recognized. Enter a valid email address."
      end
    else
      return "I'm sorry, you need to be signed in to request support. Please sign in to continue."
    end
  end
  
  def valid_email?(email)
    return email.downcase.strip == current_user.email.downcase.strip
  end
end
