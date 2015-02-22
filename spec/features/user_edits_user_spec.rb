require 'rails_helper'

feature 'User edits user' do
  background { sign_in(user) }
  given(:user) { create(:user, :all_roles) }
  given(:other_user) { create(:user, :all_roles) }

  context 'when details are valid' do
    scenario 'they see a success message' do
      visit edit_admin_user_path(other_user)

      expect(page).to have_content('Edit User')

      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name

      fill_in 'user_entry_first_name', :with => first_name
      fill_in 'user_entry_last_name', :with => last_name
      fill_in 'user_entry_display_name', :with => "#{first_name} #{last_name}"

      click_button 'Save'

      other_user.reload

      expect(page).to have_content(
        I18n.t(
          'ar.success.messages.updated',
          :model => I18n.t('ar.models.user')))
      expect(other_user.first_name).to eq(first_name)
      expect(other_user.last_name).to eq(last_name)
      expect(other_user.display_name).to eq("#{first_name} #{last_name}")
    end
  end

  context 'when details are invalid' do
    scenario 'they see an error message' do
      visit edit_admin_user_path(other_user)

      expect(page).to have_content('Edit User')

      fill_in 'user_entry_first_name', :with => ''

      click_button 'Save'

      expect(page).to have_content(/error/i)
    end
  end
end
