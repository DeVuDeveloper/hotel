FactoryBot.define do
  factory :room do
    sequence(:name) { |n| room_names[n - 1] }
    sequence(:room_type) { |n| room_type[n - 1] }
    number_of_beds { 2 }
    price_per_night { 100 }
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
