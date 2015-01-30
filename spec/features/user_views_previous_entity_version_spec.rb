require 'rails_helper'

feature 'User views previous entity version' do
  background { sign_in(create(:user, :authenticated, :entity_user)) }
  given(:entity) do
    temp_entity = create(:entity)
    temp_entity = change_entity_name(temp_entity)
    change_entity_name(temp_entity)
  end
  given(:original_entity) { version.reify }
  given(:version) { entity.previous_version.version }

  context 'when it exists' do
    scenario 'they see the previous entity version' do
      visit entity_path(entity, :version => version.id)

      expect(page).to have_content(original_entity.name)
      expect(current_path).to eq("/entities/#{entity.id}")
      expect(current_url).to match(/version=#{version.id}/)
    end
  end

  def change_entity_name(entity)
    entity.name = Faker::Company.name
    entity.save!
    entity
  end
end
