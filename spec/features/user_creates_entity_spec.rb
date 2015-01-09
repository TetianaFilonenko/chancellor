require 'rails_helper'

feature 'user creates a new entity' do
  background { sign_in(user) }

  context 'when authorized' do
    given(:user) do
      authorized_user = build(:user, :confirmed)
      authorized_user.roles << build(:user_role_entity_admin)
      authorized_user.save!
      authorized_user
    end

    scenario 'valid details show succeed' do
      visit new_entity_path

      fill_in 'entity_name', :with => Faker::Company.name
      fill_in 'entity_reference', :with => Faker::Number.number(8)
      fill_in 'entity_street_address', :with => Faker::Address.street_address
      fill_in 'entity_city', :with => Faker::Address.street_address
      fill_in 'entity_region', :with => Faker::Address.state
      fill_in 'entity_region_code', :with => Faker::Address.zip_code
      fill_in 'entity_country', :with => 'United States'

      click_button 'Save'

      expect(page).to have_content(/success/i)
    end

    scenario 'invalid details fail' do
      visit new_entity_path

      click_button 'Save'

      expect(page).not_to have_content(/created/i)
    end
  end

  context 'when not authorized' do
    given(:user) { create(:user, :confirmed) }

    scenario 'show no access message' do
      visit new_entity_path

      expect(page).to have_content(
        I18n.t('entity_policy.new?', :scope => :pundit))
    end
  end
end
