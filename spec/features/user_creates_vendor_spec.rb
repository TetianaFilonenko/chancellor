require 'rails_helper'

feature 'User creates vendor' do
  background do
    contact
    location
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:contact) { create(:contact, :entity => entity) }
  given(:location) { create(:location, :entity => entity) }
  given(:salesperson) { create(:salesperson, :entity => create(:entity)) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit new_entity_vendor_path(entity)

      expect(page).to have_content('New Vendor')

      select_by_value('vendor_entry_default_contact_id', contact.id)
      select_by_value('vendor_entry_default_location_id', location.id)
      fill_in 'vendor_entry_reference', :with => Faker::Number.number(8)
      check 'Is Active'

      click_button 'Save'

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.created',
          :model => I18n.t('ar.models.vendor')))
      expect(entity.vendor).to be_present
      expect(entity.vendor.default_contact).to eq(contact)
      expect(entity.vendor.default_location).to eq(location)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_entity_vendor_path(entity)

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
