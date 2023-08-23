FactoryBot.define do
  factory :room do
    association :hotel
    sequence(:name) { |n| "Room #{n}" }
    sequence(:room_type) { |n| "Room Type #{n}" }
    number_of_beds { 2 } 
    price_per_night { 165.0 } 
    sequence(:description) { |n| "Description for Room #{n}" }

    transient do
      image_count { 3 } 
    end

    after(:create) do |room, evaluator|
      evaluator.image_count.times do |i|
        image_path = Rails.root.join("spec", "images", "room#{i + 1}.jpg")
        room.image.attach(io: File.open(image_path), filename: "room#{i + 1}.jpg", content_type: "image/jpeg")
      end
    end
  end
end

