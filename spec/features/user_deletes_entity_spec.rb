require 'rails_helper'

feature 'User deletes entity' do
  background { sign_in(create(:user)) }
  given(:entity) { create(:entity) }

  scenario 'that exists' do
    visit entity_path(entity)

    click_link 'Delete'

    # Make sure that the Entity instance if up-to date
    entity.reload

    expect(entity.deleted_at).to be_present
    expect(page).to have_content(/was successfully deleted/i)
  end
end
