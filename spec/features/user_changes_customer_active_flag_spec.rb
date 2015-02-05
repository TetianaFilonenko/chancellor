require 'rails_helper'

feature 'User changes customer active flag' do
  background do
    # Create the instances so that they're available in the drop downs.
    contact
    location
    salesperson
    sign_in(user)
  end
  # given(:is_active) { 1 }
  given(:entity) { create(:entity) }
  given(:contact) { create(:contact, :entity => entity) }
  given(:customer) do
    create(:customer,
           :default_contact => contact,
           :default_location => location,
           :entity => entity,
           :is_active => is_active,
           :salesperson => salesperson)
  end
  given(:location) { create(:location, :entity => entity) }
  given(:salesperson) { create(:salesperson, :entity => create(:entity)) }
  given(:user) { create(:user, :all_roles) }

  context 'when the customer is active' do
    given(:is_active) { 1 }

    scenario 'the customer is no longer active' do
      visit edit_customer_path(customer)

      expect(page).to have_content('Edit Customer')

      uncheck 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.customer')))
      expect(entity.customer.is_active).to eq(0)
      expect(entity.customer.default_contact).to eq(contact)
      expect(entity.customer.default_location).to eq(location)
      expect(entity.customer.salesperson).to eq(salesperson)
    end
  end

  context 'when the customer is not active' do
    given(:is_active) { 0 }

    scenario 'the customer is active' do
      visit edit_customer_path(customer)

      expect(page).to have_content('Edit Customer')

      check 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.customer')))
      expect(entity.customer.is_active).to eq(1)
      expect(entity.customer.default_contact).to eq(contact)
      expect(entity.customer.default_location).to eq(location)
      expect(entity.customer.salesperson).to eq(salesperson)
    end
  end
end
