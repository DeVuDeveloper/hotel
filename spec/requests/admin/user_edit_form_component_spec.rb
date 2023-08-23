require "rails_helper"

RSpec.describe "Admin User Edit Form", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /admin/dashboard/users" do
    it "renders the user edit form" do
      get edit_admin_dashboard_user_path(user)
      expect(response).to have_http_status(200)
      expect(response.body).to include("<form")
      expect(response.body).to include("Email")
      expect(response.body).to include("Role")
      expect(response.body).to include("Update User")
      expect(response.body).to include("Cancel")
    end
  end
end
