class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :room_type, presence: true
  validates :number_of_beds, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :image, presence: true



  broadcasts_to ->(room) { "rooms" }, inserts_by: :prepend
  scope :ordered, -> { order(id: :desc) }

  def booked_by_user?(user)
    reservations.where(user: user).exists?
  end

  def availability_data
    current_season_price = case Time.now.month
                           when 6..8
                             summer_price
                           when 12, 1, 2
                             winter_price
                           when 3..5
                             spring_price
                           else
                             autumn_price
                           end

    calendars.map do |calendar|
      {
        title: calendar.available ? "Available" : "Booked",
        start: calendar.date,
        price: calendar.available ? current_season_price : nil,
        backgroundColor: calendar.available ? "green" : "red",
      }
    end
  end

  private

  def summer_available?
    Date.today.month >= 6 && Date.today.month <= 8
  end

  def winter_available?
    Date.today.month == 12 || Date.today.month <= 2
  end

  def spring_available?
    Date.today.month >= 3 && Date.today.month <= 5
  end

  def autumn_available?
    Date.today.month >= 9 && Date.today.month <= 11
  end
end
