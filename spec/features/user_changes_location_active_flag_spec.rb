require 'rails_helper'

feature 'User changes location active flag' do
  background do
    # Create the instances so that they're available in the drop downs.
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:location) { create(:location, :entity => entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when the location is active' do
    given(:is_active) { 1 }

    scenario 'the location is no longer active' do
      visit edit_location_path(location)

      expect(page).to have_content('Edit Location')

      uncheck 'Is Active'

      click_button 'Save'

      location.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.location')))
      expect(location.is_active).to eq(0)
    end
  end

  context 'when the location is not active' do
    given(:is_active) { 0 }

    scenario 'the location is active' do
      visit edit_location_path(location)

      expect(page).to have_content('Edit Location')

      check 'Is Active'

      click_button 'Save'

      location.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.location')))
      expect(location.is_active).to eq(1)
    end
  end
end
