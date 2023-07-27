class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :room_type, presence: true
  validates :number_of_beds, numericality: {greater_than: 0}
  validates :price_per_night, numericality: {greater_than_or_equal_to: 0}
  validates :description, presence: true
  validates :image, presence: true

  scope :ordered, -> { order(id: :desc) }

  after_create_commit -> { broadcast_prepend_to "rooms", partial: "admin/dashboard/rooms/room", locals: {room: self}, target: "rooms" }
end
