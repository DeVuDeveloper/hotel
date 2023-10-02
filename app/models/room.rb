# frozen_string_literal: true

class Room < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :hotel
  has_many :reservations, dependent: :destroy
  has_one :calendar, dependent: :destroy
  has_one_attached :image
  has_many :likes

  validates :name, presence: true
  validates :room_type, presence: true
  validates :number_of_beds, numericality: {greater_than: 0}
  validates :description, presence: true
  validates :image, presence: true
  validates :summer_price, numericality: {greater_than_or_equal_to: 0}
  validates :winter_price, numericality: {greater_than_or_equal_to: 0}
  validates :spring_price, numericality: {greater_than_or_equal_to: 0}
  validates :autumn_price, numericality: {greater_than_or_equal_to: 0}

  broadcasts_to ->(_room) { "rooms" }, inserts_by: :prepend
  scope :ordered, -> { order(id: :desc) }

  def booked_by_user?(user)
    reservations.where(user: user).exists?
  end

  def generate_calendar_entries_for_seasonal_prices
    return unless calendar.blank?

    create_calendar unless calendar

    (Date.today..1.year.from_now).each do |date|
      seasonal_price = calculate_seasonal_price(date)
      calendar.calendar_entries.build(date: date, price: seasonal_price, available: true)
    end

    calendar.save
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

  settings index: {number_of_shards: 1} do
    mappings dynamic: "false" do
      indexes :name, type: "text"
      indexes :room_type, type: "keyword"
      indexes :description, type: "text"
      indexes :summer_price, type: "float"
      indexes :winter_price, type: "float"
      indexes :spring_price, type: "float"
      indexes :autumn_price, type: "float"
    end
  end
end
