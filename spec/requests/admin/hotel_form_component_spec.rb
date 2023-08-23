require "rails_helper"

RSpec.describe "Admin Hotel Form", type: :request do
  let(:admin_user) { create(:admin_user) }

  describe "GET /admin/dashboard/hotels" do
    before do
      sign_in admin_user
    end

    it "displays the hotel form with all required fields" do
      get new_admin_dashboard_hotel_path

      expect(response.body).to include("Name")
      expect(response.body).to include("Address")
      expect(response.body).to include("Description")
      expect(response.body).to include("Contact")
      expect(response.body).to include("Submit")
    end

    it "creates a new hotel when valid information is submitted" do
      expect {
        post admin_dashboard_hotels_path, params: {
          hotel: {
            name: "Test Hotel",
            address: "Test Address",
            description: "Test Description",
            contact: "Test Contact",
            # Include multiple images as part of the request
            images: [
              Rack::Test::UploadedFile.new(Rails.root.join("spec", "images", "hotel1.jpg"), "image/jpeg"),
              Rack::Test::UploadedFile.new(Rails.root.join("spec", "images", "hotel2.jpg"), "image/jpeg")
            ]
          }
        }
      }.to change(Hotel, :count).by(1)

      expect(response).to redirect_to(admin_dashboard_hotels_path(locale: "en"))
      follow_redirect!
      expect(response.body).to include("Test Hotel")
    end

    it "displays error messages when invalid information is submitted" do
      expect {
        post admin_dashboard_hotels_path, params: {hotel: {name: "", address: ""}}
      }.not_to change(Hotel, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(CGI.unescapeHTML(response.body)).to include("Name can't be blank")
      expect(CGI.unescapeHTML(response.body)).to include("address can't be blank")
      expect(CGI.unescapeHTML(response.body)).to include("images can't be blank")
    end
  end
end
