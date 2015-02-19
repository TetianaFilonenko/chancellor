require 'rails_helper'

feature 'User changes vendor active flag' do
  background do
    # Create the instances so that they're available in the drop downs.
    contact
    location
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:contact) { create(:contact, :entity => entity) }
  given(:vendor) do
    create(:vendor,
           :default_contact => contact,
           :default_location => location,
           :entity => entity,
           :is_active => is_active)
  end
  given(:location) { create(:location, :entity => entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when the vendor is active' do
    given(:is_active) { 1 }

    scenario 'the vendor is no longer active' do
      visit edit_vendor_path(vendor)

      expect(page).to have_content('Edit Vendor')

      uncheck 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.vendor')))
      expect(entity.vendor.is_active).to eq(0)
      expect(entity.vendor.default_contact).to eq(contact)
      expect(entity.vendor.default_location).to eq(location)
    end
  end

  context 'when the vendor is not active' do
    given(:is_active) { 0 }

    scenario 'the vendor is active' do
      visit edit_vendor_path(vendor)

      expect(page).to have_content('Edit Vendor')

      check 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.vendor')))
      expect(entity.vendor.is_active).to eq(1)
      expect(entity.vendor.default_contact).to eq(contact)
      expect(entity.vendor.default_location).to eq(location)
    end
  end
end
