json.extract! notification_message, :id, :content, :user_id, :created_at, :updated_at
json.url notification_message_url(notification_message, format: :json)
