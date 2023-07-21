class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :room_type, presence: true
  validates :number_of_beds, numericality: { greater_than: 0 }
  validates :price_per_night, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
end

