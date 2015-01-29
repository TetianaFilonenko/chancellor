require 'rails_helper'

feature 'User edits location' do
  background { sign_in(user) }
  given(:entity) { create(:entity) }
  given(:user) { create(:user, :authenticated, :entity_user, :location_admin) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_location_path(entity.primary_location)
      expect(page).to have_content('Edit Location')

      # Change everything...
      fill_in 'location_location_name', :with => 'A new name'
      fill_in 'location_street_address', :with => Faker::Address.street_address
      fill_in 'location_city', :with => Faker::Address.city
      fill_in 'location_region', :with => Faker::Address.state
      fill_in 'location_region_code', :with => Faker::Address.zip

      click_on 'Save'

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.location')))
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_location_path(entity.primary_location)

      # Clear a mandatory field
      fill_in 'location_location_name', :with => nil

      click_on 'Save'

      expect(page).to have_content(/error/i)
      expect(page).not_to have_content(/saved/i)
    end
  end
end
