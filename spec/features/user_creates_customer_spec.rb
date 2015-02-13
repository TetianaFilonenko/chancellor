require 'rails_helper'

feature 'User creates customer' do
  background do
    contact
    location
    salesperson
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:contact) { create(:contact, :entity => entity) }
  given(:location) { create(:location, :entity => entity) }
  given(:salesperson) { create(:salesperson, :entity => create(:entity)) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit new_entity_customer_path(entity)

      expect(page).to have_content('New Customer')

      select_by_value('customer_entry_default_contact_id', contact.id)
      select_by_value('customer_entry_default_location_id', location.id)
      select_by_value('customer_entry_salesperson_id', salesperson.id)
      fill_in 'customer_entry_reference', :with => Faker::Number.number(8)

      click_button 'Save'

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.created',
          :model => I18n.t('ar.models.customer')))
      expect(entity.customer).to be_present
      expect(entity.customer.default_contact).to eq(contact)
      expect(entity.customer.default_location).to eq(location)
      expect(entity.customer.salesperson).to eq(salesperson)
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit new_entity_customer_path(entity)

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
