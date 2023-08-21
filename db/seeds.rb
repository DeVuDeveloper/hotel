module SeedData
  include FactoryBot::Syntax::Methods

  FactoryBot.create(:user)
  hotel = FactoryBot.create(:hotel)

  room_names = ["Cozy Room", "Bliss", "Family suite"]
  room_type = ["Double room", "Triple room", "Quad room"]
  room_images = ["room2.jpg", "room1.jpg", "room3.jpg"]
  number_of_beds = ["2", "2", "4"]
  price_per_night = ["165", "279", "364"]
  descriptions = [
    "A cozy room with a comfortable double bed, perfect for couples or solo travelers",
    "Spacious room featuring three beds, ideal for small families or groups of friends.",
    "Large and accommodating room with four beds, suitable for families or friends traveling together."
  ]
  
  3.times do |i|
    room = FactoryBot.create(:room, hotel: hotel, name: room_names[i], room_type: room_type[i], number_of_beds: number_of_beds[i], price_per_night: price_per_night[i], description: descriptions[i])
    room.image.attach(io: File.open(Rails.root.join("spec", "images", room_images[i])), filename: room_images[i], content_type: "image/jpeg")
  end
end
