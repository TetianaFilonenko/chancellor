require 'rails_helper'

feature 'user creates a new entity' do
  background { sign_in(user) }
  given(:user) { create(:user, :authenticated, :entity_admin) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit new_entity_path

      fill_in 'entity_name', :with => Faker::Company.name
      fill_in 'entity_reference', :with => Faker::Number.number(8)
      fill_in 'entity_street_address', :with => Faker::Address.street_address
      fill_in 'entity_city', :with => Faker::Address.street_address
      fill_in 'entity_region', :with => Faker::Address.state
      fill_in 'entity_region_code', :with => Faker::Address.zip_code
      fill_in 'entity_country', :with => 'United States'

      click_button 'Save'

      expect(page).to have_content(/success/i)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_entity_path

      click_button 'Save'

      expect(page).to have_content(/error/i)
      expect(page).not_to have_content(/created/i)
    end
  end
end
