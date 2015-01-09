require 'rails_helper'

feature 'User deletes entity' do
  background { sign_in(user) }
  given(:entity) { create(:entity) }

  context 'when authorized' do
    given(:user) do
      authorized_user = build(:user, :confirmed)
      authorized_user.roles << build(:user_role_entity_admin)
      authorized_user.save!
      authorized_user
    end

    scenario 'delete succeeds' do
      visit entity_path(entity)

      click_link 'Delete'

      # Make sure that the Entity instance if up-to date
      entity.reload

      expect(entity.deleted_at).to be_present
      expect(page).to have_content(/was successfully deleted/i)
    end
  end
end
