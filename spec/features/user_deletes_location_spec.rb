require 'rails_helper'

feature 'User deletes location' do
  background do
    location
    sign_in(user)
  end
  given(:location) { create(:location, :entity => entity) }
  given(:entity) { create(:entity) }
  given(:user) { create(:user, :all_roles) }

  context 'when delete succeeds' do
    scenario 'they see a success message' do
      visit entity_path(entity)

      within('#locations') do
        click_on 'Delete'
      end

      # Make sure that the AR instances are up-to date
      entity.reload
      location.reload

      expect(location.deleted_at).to be_present
      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.deleted',
          :model => I18n.t('ar.models.location')))
    end
  end

  context 'when delete fails' do
    before do
      # Set the destroy method up to fail
      allow(location).to receive(:destroy) { false }
      allow(Location).to receive(:find) { location }
    end
    scenario 'they see a failure message' do
      visit entity_path(entity)

      within('#locations') do
        click_on 'Delete'
      end

      # Make sure that the AR instances are up-to date
      entity.reload
      location.reload

      expect(location.deleted_at).not_to be_present
      expect(page).to have_content(
              I18n.t(
                'ar.failure.messages.deleted',
                :model => I18n.t('ar.models.location')))
    end
  end
end
