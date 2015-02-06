require 'rails_helper'

feature 'User edits salesperson' do
  background { sign_in(user) }
  given(:salesperson) do
    entity = create(:entity)
    create(:salesperson, :entity => entity)
  end
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_salesperson_path(salesperson)

      expect(page).to have_content('Edit Salesperson')

      fill_in 'salesperson_entry_reference', :with => Faker::Number.number(8)
      fill_in 'salesperson_entry_phone', :with => Faker::Number.number(10)

      click_button 'Save'

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.salesperson')))
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_salesperson_path(salesperson)

      fill_in 'salesperson_entry_reference', :with => ''

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
