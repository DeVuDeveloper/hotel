# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    hotel { nil }
    average_rating { 1.5 }
  end
end
