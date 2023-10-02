# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :rating, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :comment, presence: true

  broadcasts_to ->(_review) { ["reviews"] }, inserts_by: :prepend
end
