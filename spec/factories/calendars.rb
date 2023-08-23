FactoryBot.define do
  factory :calendar do
    room { nil }
    date { "2023-07-20" }
    price { "9.99" }
    available { false }
  end
end
