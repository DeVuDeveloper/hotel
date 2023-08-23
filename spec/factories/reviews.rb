FactoryBot.define do
  factory :review do
    rating { 1 }
    comment { "MyText" }
    user { nil }
    hotel { nil }
  end
end
