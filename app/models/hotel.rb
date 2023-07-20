class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :contact, presence: true
end