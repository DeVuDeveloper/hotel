# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :hotel

  validates :name, presence: true
  validates :description, presence: true
end
