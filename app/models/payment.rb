class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates :amount, numericality: {greater_than: 0}
  validates :payment_date, presence: true
  validates :payment_status, presence: true
end
