require 'rails_helper'

feature 'User edits entity' do
  background { sign_in(user) }
  given(:entity) { create(:entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_entity_path(entity)

      # Change everything...
      fill_in 'entity_entry_name', :with => Faker::Company.name
      fill_in 'entity_entry_reference', :with => Faker::Number.number(8)

      click_button 'Save'

      expect(page).to have_content(/success/i)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_entity_path(entity)

      # Clear a mandatory field
      fill_in 'entity_entry_name', :with => ''

      click_button 'Save'

      expect(page).to have_content(/error/i)
      expect(page).not_to have_content(/saved/i)
    end
  end
end
