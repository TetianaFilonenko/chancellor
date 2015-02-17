require 'rails_helper'

feature 'User views entity' do
  background { sign_in(create(:user, :all_roles)) }
  given(:entity) { create(:entity) }

  context 'when it exists' do
    scenario 'they see the entity' do
      visit entity_path(entity)

      expect(page).to have_content(entity.name)
      expect(current_path).to eq("/entities/#{entity.id}")
    end
  end
end
