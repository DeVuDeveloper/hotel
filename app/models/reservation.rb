class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :calendar, through: :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_guests, numericality: {greater_than: 0}
  validates :total_price, numericality: {greater_than_or_equal_to: 0}
  validates :status, presence: true
  validate :end_date_is_after_start_date

  enum status: {
    pending: "Pending",
    confirmed: "Confirmed",
    cancelled: "Cancelled"
  }

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
