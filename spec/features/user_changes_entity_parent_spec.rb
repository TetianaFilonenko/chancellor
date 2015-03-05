require 'rails_helper'

feature 'User changes entity parent' do
  background do
    sign_in(user)
  end
  given(:entities) do
    [
      create(:entity),
      create(:entity)
    ]
  end
  given(:entity) { entities[0] }
  given(:user) { create(:user, :all_roles) }

  context 'when we assign a parent' do
    given(:parent_entity) { entities[1] }

    scenario 'the parent is assigned' do
      visit edit_entity_path(entity)

      expect(page).to have_content('Edit Entity')

      find('//input[@id=entity_entry_parent_entity_id]', :visible => false)
        .set(parent_entity.id)

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.entity')))
      expect(entity.parent_entity).to eq(parent_entity)
    end
  end

  context 'when we change the parent' do
    before do
      entity.parent_entity = entities[1]
      entity.save!
    end
    given(:parent_entity) { create(:entity) }

    scenario 'the parent is assigned' do
      visit edit_entity_path(entity)

      expect(page).to have_content('Edit Entity')

      find('//input[@id=entity_entry_parent_entity_id]', :visible => false)
        .set(parent_entity.id)

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.entity')))
      expect(entity.parent_entity).to eq(parent_entity)
    end
  end

  context 'when we remove the parent' do
    before do
      entity.parent_entity = entities[1]
      entity.save!
    end

    scenario 'the parent is assigned' do
      visit edit_entity_path(entity)

      expect(page).to have_content('Edit Entity')

      find('//input[@id=entity_entry_parent_entity_id]', :visible => false)
        .set(nil)

      click_button 'Save'

      entity.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.entity')))
      expect(entity.parent_entity).to be_nil
    end
  end
end
