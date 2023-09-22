class MessageNotification < Noticed::Base
  deliver_by :database

  param :notification_message

  def message
    params[:notification_message].content
  end
  
  def url
    message_path(params[:notification_message])
  end
end