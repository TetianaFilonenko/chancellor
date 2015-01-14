require 'rails_helper'

feature 'User deletes entity' do
  background { sign_in(user) }
  given(:entity) { create(:entity) }

  given(:user) { create(:user, :authenticated, :entity_admin) }

  context 'when delete succeeds' do
    scenario 'they see a success message' do
      visit entity_path(entity)

      expect(page).to have_content('Delete')

      click_link 'Delete'

      # Make sure that the Entity instance if up-to date
      entity.reload

      expect(entity.deleted_at).to be_present
      expect(page).to have_content(/was successfully deleted/i)
    end
  end
end
