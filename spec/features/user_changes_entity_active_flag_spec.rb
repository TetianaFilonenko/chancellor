require 'rails_helper'

feature 'User changes entity active flag' do
  background do
    sign_in(user)
  end
  given(:entity) { create(:entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when the entity is active' do
    given(:is_active) { 1 }

    scenario 'the entity is no longer active' do
      visit edit_entity_path(entity)

      expect(page).to have_content('Edit Entity')

      uncheck 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.entity')))
      expect(entity.is_active).to eq(0)
    end
  end

  context 'when the entity is not active' do
    given(:is_active) { 0 }

    scenario 'the entity is active' do
      visit edit_entity_path(entity)

      expect(page).to have_content('Edit Entity')

      check 'Is Active'

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.entity')))
      expect(entity.is_active).to eq(1)
    end
  end
end
