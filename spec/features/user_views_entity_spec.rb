require 'rails_helper'

feature 'user views entity' do
  given(:entity) { create(:entity) }

  scenario 'that exists' do
    visit entity_path(entity)

    expect(current_path).to eq("/entities/#{entity.id}")
    expect(page).not_to have_content(/entity.name/i)
  end
  
end