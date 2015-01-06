require 'rails_helper'

feature 'User updates existing entity' do
  background { sign_in(create(:user, :confirmed)) }
  given(:entity) { create(:entity) }

  scenario 'with valid details' do
    visit edit_entity_path(entity)

    # Change everything...
    fill_in 'entity_name', :with => Faker::Company.name
    fill_in 'entity_reference', :with => Faker::Number.number(8)
    fill_in 'entity_street_address', :with => Faker::Address.street_address
    fill_in 'entity_city', :with => Faker::Address.street_address
    fill_in 'entity_region', :with => Faker::Address.state
    fill_in 'entity_region_code', :with => Faker::Address.zip_code

    click_button 'Save'

    expect(page).to have_content(/saved/i)
  end

  scenario 'with invalid details' do
    visit edit_entity_path(entity)

    # Clear a mandatory field
    fill_in 'entity_name', :with => nil

    click_button 'Save'

    expect(page).to have_content(/error/i)
    expect(page).not_to have_content(/saved/i)
  end
end
