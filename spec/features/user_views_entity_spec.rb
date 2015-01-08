require 'rails_helper'

feature 'User views entity' do
  background do
    authorized_user = build(:user, :confirmed)
    authorized_user.roles << build(:user_role_entity_admin)
    authorized_user.save!
    sign_in(authorized_user)
  end
  given(:entity) { create(:entity) }

  scenario 'that exists' do
    visit entity_path(entity)

    expect(current_path).to eq("/entities/#{entity.id}")
    expect(page).not_to have_content(/entity.name/i)
  end
end
