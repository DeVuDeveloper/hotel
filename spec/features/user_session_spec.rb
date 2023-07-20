require 'rails_helper'

RSpec.feature 'User Session' do
  scenario 'logs in the user with valid credentials' do
    user = create(:user, email: 'test@example.com', password: 'password123')
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Submit'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_current_path(root_path(locale: 'en'))
  end

  scenario 're-renders the login page with invalid credentials' do
    user = create(:user, email: 'test@example.com', password: 'password123')
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Submit'

    expect(page).to have_content('Invalid Email or password.')
    expect(page).to have_current_path(new_user_session_path(locale: 'en'))
  end
end

