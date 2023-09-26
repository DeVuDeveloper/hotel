# frozen_string_literal: true

FactoryBot.define do
  factory :newsletter_subscriber do
    email { "MyString" }
    subscribed { false }
  end
end
