require 'rails_helper'

feature 'User signs in' do
  given(:user) { create(:user) }

  context 'when user is confirmed' do
    given(:user) { create(:user, :confirmed) }

    scenario 'with valid email and password' do
      sign_in_with user.email, user.password

      expect(page).to have_content('Sign out')
    end
  end

  context 'when user is not confirmed' do
    scenario 'with valid email and password' do
      sign_in_with user.email, user.password

      expect(page).to have_content(
        I18n.t('failure.unconfirmed', :scope => :devise))
    end
  end

  scenario 'with invalid email' do
    sign_in_with 'invalid@example.com', user.password

    expect(page).to have_content(
      I18n.t(
        'failure.invalid',
        :authentication_keys => User.authentication_keys
          .join(I18n.translate(:'support.array.words_connector')),
        :scope => :devise))
  end
end
