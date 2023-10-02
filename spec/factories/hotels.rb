# frozen_string_literal: true

FactoryBot.define do
  factory :hotel do
    name { "Poseidon The Beach Hotel" }
    address { "Beach Jaz, 85310 Budva, Montenegro" }
    description do
      'Situated in Budva, a few steps from Jaz Beach,
        Poseidon The Beach Hotel features accommodation with a garden,
          free private parking, a terrace and a restaurant.'
    end
    contact { "info@poseidon-jaz.com" }

    after(:build) do |hotel|
      hotel.images.attach(
        io: File.open(Rails.root.join("spec", "images", "hotel1.jpg")),
        filename: "hotel1.jpg",
        content_type: "image/jpeg"
      )

      hotel.images.attach(
        io: File.open(Rails.root.join("spec", "images", "hotel2.jpg")),
        filename: "hotel2.jpg",
        content_type: "image/jpeg"
      )
      hotel.images.attach(
        io: File.open(Rails.root.join("spec", "images", "hotel3.jpg")),
        filename: "hotel3.jpg",
        content_type: "image/jpeg"
      )
      hotel.images.attach(
        io: File.open(Rails.root.join("spec", "images", "hotel4.jpg")),
        filename: "hotel4.jpg",
        content_type: "image/jpeg"
      )
      hotel.images.attach(
        io: File.open(Rails.root.join("spec", "images", "hotel5.jpg")),
        filename: "hotel5.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end
