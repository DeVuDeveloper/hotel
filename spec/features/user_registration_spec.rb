require "rails_helper"

RSpec.feature "User Registration" do
  scenario "User can register with valid attributes" do
    visit new_user_registration_path

    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"

    click_button "Register"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "User cannot register with invalid attributes" do
    visit new_user_registration_path

    fill_in "user_email", with: ""
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"

    click_button "Register"

    expect(page).to have_content("Email can't be blank")
  end
end
