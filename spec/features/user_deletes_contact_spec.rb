require 'rails_helper'

feature 'User deletes contact' do
  background do
    contact
    sign_in(user)
  end
  given(:contact) { create(:contact, :entity => entity) }
  given(:entity) { create(:entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when delete succeeds' do
    scenario 'they see a success message' do
      visit entity_path(entity)

      within('#contacts') do
        click_on 'Delete'
      end

      # Make sure that the AR instance is up-to date
      contact.reload

      expect(contact.deleted_at).to be_present
      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.deleted',
          :model => I18n.t('ar.models.contact')))
    end
  end

  context 'when delete fails' do
    before do
      # Set the destroy method up to fail
      allow(contact).to receive(:destroy) { false }
      allow(Contact).to receive(:find) { contact }
    end
    scenario 'they see a failure message' do
      visit entity_path(entity)

      within('#contacts') do
        click_on 'Delete'
      end

      # Make sure that the AR instance is up-to date
      contact.reload

      expect(contact.deleted_at).not_to be_present
      expect(page).to have_content(
        I18n.t(
          'ar.failure.messages.deleted',
          :model => I18n.t('ar.models.contact')))
    end
  end
end
