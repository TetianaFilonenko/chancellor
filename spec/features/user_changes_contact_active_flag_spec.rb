require 'rails_helper'

feature 'User changes contact active flag' do
  background do
    # Create the instances so that they're available in the drop downs.
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:contact) { create(:contact, :entity => entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when the contact is active' do
    given(:is_active) { 1 }

    scenario 'the contact is no longer active' do
      visit edit_contact_path(contact)

      expect(page).to have_content('Edit Contact')

      uncheck 'Is Active'

      click_button 'Save'

      contact.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.contact')))
      expect(contact.is_active).to eq(0)
    end
  end

  context 'when the contact is not active' do
    given(:is_active) { 0 }

    scenario 'the contact is active' do
      visit edit_contact_path(contact)

      expect(page).to have_content('Edit Contact')

      check 'Is Active'

      click_button 'Save'

      contact.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.contact')))
      expect(contact.is_active).to eq(1)
    end
  end
end
