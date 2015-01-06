require 'rails_helper'

feature 'User is not signed in' do
  given(:user) { create(:user) }

  scenario 'visits the home page' do
    # sign_in_with user.email, user.password
    visit '/'

    # expect(page).to have_content('Sign out')
    expect(page).to have_content('Sign in')
  end
end
