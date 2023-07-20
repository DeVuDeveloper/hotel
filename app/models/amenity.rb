class Amenity < ApplicationRecord
  belongs_to :hotel

  validates :name, presence: true
end
