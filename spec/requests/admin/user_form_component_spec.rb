require 'rails_helper'

RSpec.describe 'Admin User Form', type: :request do
  let(:super_admin_user) { create(:user, role: 'super_admin') } 

  before do
    sign_in super_admin_user
  end

  describe "GET /admin/dashboard/users" do
    it "displays the form with all required fields" do
      get new_admin_dashboard_user_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Email")
      expect(response.body).to include("Password")
      expect(response.body).to include("Password confirmation") 
      expect(response.body).to include("Register")
    end

    it "displays error messages when user has errors" do
      user = User.new
      user.errors.add(:email, "can't be blank")
      user.errors.add(:password, "can't be blank")

      post '/admin/dashboard/users', params: { user: user.attributes, role: 'admin' }
      expect(CGI.unescapeHTML(response.body)).to include("Email can't be blank")
      expect(CGI.unescapeHTML(response.body)).to include("password can't be blank")
    end
  end

  it "creates a new admin or manager when valid information is submitted" do
    email = SecureRandom.hex(8) + "@example.com"
    expect {
      post admin_dashboard_users_path, params: { user: { email: email, password: "password", password_confirmation: "password" }, role: "admin" }
    }.to change(User, :count).by(1)

    expect(response).to redirect_to(admin_dashboard_users_path(locale: 'en'))
  end
end











