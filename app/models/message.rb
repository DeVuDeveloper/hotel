class Message < ApplicationRecord
  belongs_to :hotel

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :content, presence: true
end
