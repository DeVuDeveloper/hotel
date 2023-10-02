# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { 1 }
    comment { "MyText" }
    user { nil }
    hotel { nil }
  end
end
