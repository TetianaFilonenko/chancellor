require 'rails_helper'

feature 'User views entity' do
  background { sign_in(create(:user)) }
  given(:entity) { create(:entity) }

  scenario 'that exists' do
    visit entity_path(entity)

    expect(current_path).to eq("/entities/#{entity.id}")
    expect(page).not_to have_content(/entity.name/i)
  end
end
