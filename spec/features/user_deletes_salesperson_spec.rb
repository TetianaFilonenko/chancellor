require 'rails_helper'

feature 'User deletes salesperson' do
  background { sign_in(user) }
  given(:salesperson) { create(:salesperson, :entity => entity) }
  given(:entity) do
    create(:entity)
  end
  given(:user) { create(:user, :all_roles) }

  context 'when delete succeeds' do
    scenario 'they see a success message' do
      visit entity_path(salesperson.entity)

      within('#salesperson-actions') do
        click_on 'Delete'
      end

      # Make sure that the AR instances are up-to date
      entity.reload
      salesperson.reload

      expect(salesperson.deleted_at).to be_present
      expect(entity.salesperson).to be_present
      expect(page).to have_content(/was successfully deleted/i)
    end
  end
end
