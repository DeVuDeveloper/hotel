FactoryBot.define do
  factory :room do
    name { "Test Room" }
    room_type { "Room Type" }
    number_of_beds { 1 }
    price_per_night { "100" }
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
