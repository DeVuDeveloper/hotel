require "rails_helper"

RSpec.describe "Admin Room Form", type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:hotel) { FactoryBot.create(:hotel) }

  describe "GET /admin/dashboard/hotels/:hotel_id/rooms/new" do
    before do
      sign_in admin_user
    end

    it "displays the room form with all required fields" do
      get new_admin_dashboard_hotel_room_path(hotel)

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Name")
      expect(response.body).to include("Room Type")
      expect(response.body).to include("Beds")
      expect(response.body).to include("Price")
      expect(response.body).to include("Description")
      expect(response.body).to include("Submit")
    end

    it "creates a new room when valid information is submitted" do
      expect {
        post admin_dashboard_hotel_rooms_path(hotel), params: {
          room: {
            name: "Test Room",
            room_type: "Single",
            number_of_beds: 1,
            price_per_night: 100,
            description: "Test Description",
            hotel_id: hotel.id,
            image: Rack::Test::UploadedFile.new(Rails.root.join("spec", "images", "room1.jpg"), "image/jpeg")
          }
        }
      }.to change(Room, :count).by(1)

      expect(response).to redirect_to(admin_dashboard_hotel_rooms_path(hotel, locale: "en"))
      follow_redirect!
      expect(response.body).to include("Test Room")
    end

    it "displays error messages when invalid information is submitted" do
      expect {
        post admin_dashboard_hotel_rooms_path(hotel), params: {room: {name: "", room_type: "", number_of_beds: "", price_per_night: "", description: "", hotel_id: hotel.id}}
      }.not_to change(Room, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(CGI.unescapeHTML(response.body)).to include("Name can't be blank")
      expect(CGI.unescapeHTML(response.body)).to include("room type can't be blank")
      expect(CGI.unescapeHTML(response.body)).to include("number of beds is not a number")
      expect(CGI.unescapeHTML(response.body)).to include("price per night is not a number")
      expect(CGI.unescapeHTML(response.body)).to include("description can't be blank")
      expect(CGI.unescapeHTML(response.body)).to include("image can't be blank")
    end
  end
end
