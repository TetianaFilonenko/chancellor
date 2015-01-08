require 'rails_helper'

feature 'User edits existing entity' do
  background { sign_in(user) }
  given(:entity) { create(:entity) }

  context 'when authorized' do
    given(:user) do
      authorized_user = build(:user, :confirmed)
      authorized_user.roles << build(:user_role_entity_admin)
      authorized_user.save!
      authorized_user
    end

    scenario 'valid details succeed' do
      visit edit_entity_path(entity)

      # Change everything...
      fill_in 'entity_name', :with => Faker::Company.name
      fill_in 'entity_reference', :with => Faker::Number.number(8)
      fill_in 'entity_street_address', :with => Faker::Address.street_address
      fill_in 'entity_city', :with => Faker::Address.street_address
      fill_in 'entity_region', :with => Faker::Address.state
      fill_in 'entity_region_code', :with => Faker::Address.zip_code

      click_button 'Save'

      expect(page).to have_content(/saved/i)
    end

    scenario 'invalid details fail' do
      visit edit_entity_path(entity)

      # Clear a mandatory field
      fill_in 'entity_name', :with => nil

      click_button 'Save'

      expect(page).to have_content(/error/i)
      expect(page).not_to have_content(/saved/i)
    end
  end

  context 'when not authorized' do
    given(:user) { create(:user, :confirmed) }

    scenario 'show no access message' do
      visit edit_entity_path(entity)

      expect(page).to have_content(
        I18n.t('entity_policy.edit?', :scope => :pundit))
    end
  end
end
