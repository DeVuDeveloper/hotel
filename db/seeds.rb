# Create a user
user = User.create(
  email: "superadmin@example.com",
  password: "password",
  role: "super_admin"
)

# Create a hotel
hotel = Hotel.create(
  name: "Poseidon The Beach Hotel",
  address: "Beach Jaz, 85310 Budva, Montenegro",
  description: "Situated in Budva, a few steps from Jaz Beach, Poseidon The Beach Hotel features accommodation with a garden, free private parking, a terrace, and a restaurant.",
  contact: "info@poseidon-jaz.com"
)

# Create rooms
room_data = [
  {
    name: "Room 1",
    room_type: "Single",
    number_of_beds: 2,
    autumn_price: 100,
    winter_price: 1050,
    spring_price: 114,
    summer_price: 125,
    description: "Test Description"
  },
  # Add more room data as needed
]

room_data.each do |room_attrs|
  room = Room.create(room_attrs)
  
  # Attach an image to the room
  room.image.attach(
    io: File.open(Rails.root.join("spec", "images", "room1.jpg")),
    filename: "room1.jpg",
    content_type: "image/jpeg"
  )

  # Associate the room with the hotel
  hotel.rooms << room
end

