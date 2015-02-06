require 'rails_helper'

feature 'User creates salesperson' do
  background do
    location
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:location) do
    create(:location, :entity => entity, :location_name => entity.name)
  end
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit new_entity_salesperson_path(entity)

      expect(page).to have_content('New Salesperson')

      select('female', :from => 'Gender')
      select_by_value('salesperson_entry_location_id', location.id)
      fill_in 'salesperson_entry_reference', :with => Faker::Number.number(8)
      fill_in 'salesperson_entry_phone', :with => Faker::Number.number(10)

      click_button 'Save'

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.created',
          :model => I18n.t('ar.models.salesperson')))
      expect(entity.salesperson).to be_present
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_entity_path

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
