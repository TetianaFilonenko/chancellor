require 'rails_helper'

feature 'User updates customer' do
  background do
    # Create the instances so that they're available in the drop downs.
    contact
    location
    salesperson
    sign_in(user)
  end
  given(:entity) do
    temp_entity = create(:entity)
    create(:contact, :entity => temp_entity)
    create(:location, :entity => temp_entity)
    create(:salesperson, :entity => temp_entity)
    temp_entity
  end
  given(:contact) { create(:contact, :entity => entity) }
  given(:customer) do
    create(:customer,
           :default_contact => entity.contacts.first,
           :default_location => entity.locations.first,
           :entity => entity,
           :salesperson => create(:salesperson, :entity => create(:entity)))
  end
  given(:location) { create(:location, :entity => entity) }
  given(:salesperson) { create(:salesperson, :entity => create(:entity)) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_customer_path(customer)

      expect(page).to have_content('Edit Customer')

      select_by_value('customer_entry_default_contact_id', contact.id)
      select_by_value('customer_entry_default_location_id', location.id)
      select_by_value('customer_entry_salesperson_id', salesperson.id)

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.customer')))
      expect(entity.customer).to be_present
      expect(entity.customer.default_contact).to eq(contact)
      expect(entity.customer.default_location).to eq(location)
      expect(entity.customer.salesperson).to eq(salesperson)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_customer_path(customer)

      fill_in 'customer_entry_reference', :with => ''

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
