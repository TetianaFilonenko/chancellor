require 'rails_helper'

feature 'User views entities' do
  background do
    authorized_user = create(:user, :authenticated, :entity_admin)
    sign_in(authorized_user)
  end

  scenario 'no entities exist' do
    visit entities_path

    expect(page).to have_content(/no entities found/i)
  end

  scenario 'at least one entity exists' do
    entity = create(:entity)

    visit entities_path

    expect(page).to have_content(entity.name)
  end
end
