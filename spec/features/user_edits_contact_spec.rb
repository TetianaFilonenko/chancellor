require 'rails_helper'

feature 'user edits contact' do
  background { sign_in(user) }
  given(:contact) { create(:contact, :entity => create(:entity)) }
  given(:user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_contact_path(contact)

      expect(page).to have_content('Edit Contact')

      fill_in 'contact_title', :with => Faker::Name.title
      fill_in 'contact_first_name', :with => Faker::Name.first_name
      fill_in 'contact_last_name', :with => Faker::Name.last_name
      fill_in 'contact_email_address', :with => Faker::Internet.email
      fill_in 'contact_fax_number', :with => Faker::PhoneNumber.phone_number
      fill_in 'contact_mobile_number', :with => Faker::PhoneNumber.cell_phone
      fill_in 'contact_phone_number', :with => Faker::PhoneNumber.phone_number

      click_on 'Save'

      expect(page.current_path).to eq(entity_path(contact.entity))
      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.contact')))
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_contact_path(contact)

      fill_in 'contact_first_name', :with => ''

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
