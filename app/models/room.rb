class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations, dependent: :destroy
  has_one :calendar, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :room_type, presence: true
  validates :number_of_beds, numericality: {greater_than: 0}
  validates :description, presence: true
  validates :image, presence: true
  validates :summer_price, numericality: {greater_than_or_equal_to: 0}
  validates :winter_price, numericality: {greater_than_or_equal_to: 0}
  validates :spring_price, numericality: {greater_than_or_equal_to: 0}
  validates :autumn_price, numericality: {greater_than_or_equal_to: 0}

  broadcasts_to ->(room) { "rooms" }, inserts_by: :prepend
  scope :ordered, -> { order(id: :desc) }

  def booked_by_user?(user)
    reservations.where(user: user).exists?
  end

  def generate_calendar_entries_for_seasonal_prices
    if calendar.blank?
      create_calendar unless calendar

      (Date.today..1.year.from_now).each do |date|
        seasonal_price = calculate_seasonal_price(date)
        calendar.calendar_entries.build(date: date, price: seasonal_price, available: true)
      end

      calendar.save
    end
  end

  def calculate_seasonal_price(date)
    case date.month
    when 6..8
      summer_price
    when 12, 1, 2
      winter_price
    when 3..5
      spring_price
    else
      autumn_price
    end
  end
end
