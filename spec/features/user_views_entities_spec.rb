require 'rails_helper'

feature 'User views entities' do
  background { sign_in(create(:user)) }

  scenario 'no entities exist' do
    visit entities_path

    expect(page).to have_content(/no entities found/i)
  end

  scenario 'at least one entity exists' do
    create(:entity)

    visit entities_path

    expect(page).not_to have_content(/no entities found/i)
  end
end
