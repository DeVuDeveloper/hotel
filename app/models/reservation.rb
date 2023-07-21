class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_guests, numericality: {greater_than: 0}
  validates :total_price, numericality: {greater_than_or_equal_to: 0}
  validates :status, presence: true
end
