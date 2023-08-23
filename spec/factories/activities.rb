FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.words(number: 2).join(" ") }
    description { Faker::Lorem.paragraph }
    hotel { nil }
  end
end
