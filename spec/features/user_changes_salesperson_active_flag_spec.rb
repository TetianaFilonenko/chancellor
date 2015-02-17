require 'rails_helper'

feature 'User changes salesperson active flag' do
  background do
    # Create the instances so that they're available in the drop downs.
    contact
    location
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:contact) { create(:contact, :entity => entity) }
  given(:location) { create(:location, :entity => entity) }
  given(:salesperson) do
    create(:salesperson,
           :default_location => location,
           :entity => entity,
           :is_active => is_active)
  end
  given(:user) { create(:user, :all_roles) }

  context 'when the salesperson is active' do
    given(:is_active) { 1 }

    scenario 'the salesperson is no longer active' do
      visit edit_salesperson_path(salesperson)

      expect(page).to have_content('Edit Salesperson')

      uncheck 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.salesperson')))
      expect(entity.salesperson.is_active).to eq(0)
      expect(entity.salesperson.default_location).to eq(location)
    end
  end

  context 'when the salesperson is not active' do
    given(:is_active) { 0 }

    scenario 'the salesperson is active' do
      visit edit_salesperson_path(salesperson)

      expect(page).to have_content('Edit Salesperson')

      check 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.salesperson')))
      expect(entity.salesperson.is_active).to eq(1)
      expect(entity.salesperson.default_location).to eq(location)
    end
  end
end
