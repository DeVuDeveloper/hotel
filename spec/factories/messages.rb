# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    name { "MyString" }
    email { "valid@example.com" }
    content { "MyText" }
    hotel { nil }
  end
end
