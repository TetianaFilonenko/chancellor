require 'rails_helper'

feature 'User views entities' do
  background do
    authorized_user = build(:user, :confirmed)
    authorized_user.roles << build(:user_role_entity_admin)
    authorized_user.save!
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
