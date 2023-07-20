class Rating < ApplicationRecord
  belongs_to :hotel

  validates :average_rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
