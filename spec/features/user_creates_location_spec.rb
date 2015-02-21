require 'rails_helper'

feature 'user creates location' do
  background { sign_in(user) }
  given(:entity) { create(:entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit new_entity_location_path(entity)

      fill_in 'location_entry_location_name', :with => Faker::Company.name
      fill_in 'location_entry_street_address',
              :with => Faker::Address.street_address
      fill_in 'location_entry_city', :with => Faker::Address.street_address
      fill_in 'location_entry_region', :with => Faker::Address.state
      fill_in 'location_entry_region_code', :with => Faker::Address.zip_code
      fill_in 'location_entry_country', :with => 'United States'

      click_on 'Save'

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.created',
          :model => I18n.t('ar.models.location')))
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_entity_location_path(entity)

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
