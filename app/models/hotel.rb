# frozen_string_literal: true

class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :contact, presence: true
  validates :images, presence: true

  after_create_commit lambda {
                        broadcast_prepend_to "hotels", partial: "admin/dashboard/hotels/hotel",
                          locals: {hotel: self}, target: "hotels"
                      }
end
