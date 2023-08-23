class Calendar < ApplicationRecord
  belongs_to :room

  validates :date, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :available, inclusion: {in: [true, false]}
end
