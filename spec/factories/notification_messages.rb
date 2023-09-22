FactoryBot.define do
  factory :notification_message do
    content { "MyText" }
    user { nil }
  end
end
