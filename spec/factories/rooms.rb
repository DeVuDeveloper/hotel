FactoryBot.define do
  factory :room do
    name { "MyString" }
    room_type { "MyString" }
    number_of_beds { 1 }
    price_per_night { "9.99" }
    description { "MyText" }
    association :hotel
  end
end
