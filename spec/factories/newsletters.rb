# frozen_string_literal: true

FactoryBot.define do
  factory :newsletter do
    subject { "MyString" }
    content { "MyText" }
  end
end
