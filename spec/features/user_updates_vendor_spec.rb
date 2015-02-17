require 'rails_helper'

feature 'User updates vendor' do
  background do
    # Create the instances so that they're available in the drop downs.
    contact
    location
    sign_in(user)
  end
  given(:entity) do
    temp_entity = create(:entity)
    create(:contact, :entity => temp_entity)
    create(:location, :entity => temp_entity)
    temp_entity
  end
  given(:contact) { create(:contact, :entity => entity) }
  given(:vendor) do
    create(:vendor,
           :default_contact => entity.contacts.first,
           :default_location => entity.locations.first,
           :entity => entity)
  end
  given(:location) { create(:location, :entity => entity) }
  given(:salesperson) { create(:salesperson, :entity => create(:entity)) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_vendor_path(vendor)

      expect(page).to have_content('Edit Vendor')

      select_by_value('vendor_entry_default_contact_id', contact.id)
      select_by_value('vendor_entry_default_location_id', location.id)

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.vendor')))
      expect(entity.vendor).to be_present
      expect(entity.vendor.default_contact).to eq(contact)
      expect(entity.vendor.default_location).to eq(location)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_vendor_path(vendor)

      fill_in 'vendor_entry_reference', :with => ''

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
