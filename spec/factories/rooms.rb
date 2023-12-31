# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    room_type { "Single" }
    number_of_beds { 2 }
    autumn_price { 100 }
    winter_price { 1050 }
    spring_price { 114 }
    summer_price { 125 }
    description { "Test Description" }

    association :hotel

    after(:build) do |room|
      room.image.attach(
        io: File.open(Rails.root.join("spec", "images", "room1.jpg")),
        filename: "room1.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end
