# frozen_string_literal: true

class UserMessage < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  after_create_commit lambda {
                        broadcast_prepend_to "user_messages", partial: "admin/dashboard/user_messages/user_message",
                          locals: {user_message: self}, target: "user_messages"
                      }
end
