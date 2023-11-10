
hotel = Hotel.first

room_names = ["Cozy Room", "Bliss", "Family suite", "Blue"]
room_type = ["Double room", "Triple room", "Quad room", "Studio"]
room_images = ["room2.jpg", "room1.jpg", "room3.jpg", "room4.jpg"]
number_of_beds = %w[2 2 4 5]
autumn_price = %w[165 279 364 420]
winter_price = %w[169 289 369 430]
spring_price = %w[159 279 357 418]
summer_price = %w[169 297 374 442]
descriptions = [
  "A cozy room with a comfortable double bed, perfect for couples or solo travelers",
  "Spacious room featuring three beds, ideal for small families or groups of friends.",
  "Large and accommodating room with four beds, suitable for families or friends traveling together.",
  'The studio room offers a spacious open layout that seamlessly combines a comfortable sleeping area, a cozy living space, and a well-equipped kitchenette. '
]

4.times do |i|
  room = FactoryBot.create(:room, hotel: hotel, name: room_names[i], room_type: room_type[i],
    number_of_beds: number_of_beds[i], autumn_price: autumn_price[i],
    winter_price: winter_price[i], spring_price: spring_price[i],
    summer_price: summer_price[i], description: descriptions[i])
  room.image.attach(io: File.open(Rails.root.join("spec", "images", room_images[i])), filename: room_images[i],
    content_type: "image/jpeg")
end
