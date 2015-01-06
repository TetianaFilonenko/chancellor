require 'rails_helper'

feature 'User signs in' do
  given(:user) { create(:user) }

  scenario 'with valid email and password' do
    sign_in_with user.email, user.password

    expect(page).to have_content('Sign out')
  end

  scenario 'with invalid email' do
    sign_in_with 'invalid@example.com', user.password

    expect(page).to have_content('Sign in')
  end
end
