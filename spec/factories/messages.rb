FactoryBot.define do
  factory :message do
    name { "MyString" }
    email { "valid@example.com" }
    content { "MyText" }
    hotel { nil }
  end
end
