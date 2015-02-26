require 'rails_helper'

feature 'User edits location' do
  background { sign_in(user) }
  given(:location) { create(:location, :entity => create(:entity)) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_location_path(location)
      expect(page).to have_content('Edit Location')

      # Change everything...
      fill_in 'location_entry_location_name', :with => 'A new name'
      fill_in 'location_entry_street_address',
              :with => Faker::Address.street_address
      fill_in 'location_entry_city', :with => Faker::Address.city
      fill_in 'location_entry_region', :with => Faker::Address.state
      fill_in 'location_entry_region_code', :with => Faker::Address.zip

      click_on 'Save'

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.location')))
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_location_path(location)

      # Clear a mandatory field
      fill_in 'location_entry_location_name', :with => nil

      click_on 'Save'

      expect(page).to have_content(/error/i)
      expect(page).not_to have_content(/saved/i)
    end
  end
end
