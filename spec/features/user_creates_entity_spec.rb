require 'rails_helper'

feature 'user creates entity' do
  background { sign_in(user) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit new_entity_path

      fill_in 'entity_entry_name', :with => Faker::Company.name
      fill_in 'entity_entry_reference', :with => Faker::Number.number(8)

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
