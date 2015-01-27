require 'rails_helper'

feature 'User manages user' do
  background { sign_in(admin_user) }
  given(:admin_user) { create(:user, :authenticated, :user_admin) }
  given(:user) { create(:user) }

  scenario 'disables user' do
    visit admin_user_path(user)

    expect(page).to have_content(/active/i)

    visit edit_admin_user_path(user)

    uncheck 'Is active'
    click_on 'Save'

    user.reload

    expect(page).to have_content(/success/i)
    expect(user.active?).to eq(false)
  end

  scenario 'enables user' do
    user.is_active = 0
    user.save!

    visit admin_user_path(user)

    expect(page).to have_content(/inactive/i)

    visit edit_admin_user_path(user)

    check 'Is active'
    click_on 'Save'

    user.reload

    expect(page).to have_content(/success/i)
    expect(user.active?).to eq(true)
  end

  scenario 'add role' do
    visit new_admin_user_role_path(user)

    select('Authenticated')
    click_on 'Save'

    user.reload

    expect(page).to have_content(
      I18n.t(
        'app.admin.grant_role.success',
        :role_name => 'authenticated',
        :user_name => user.display_name))
    expect(user.has_role?(:authenticated)).to eq(true)
  end

  scenario 'remove role' do
    user.add_role :authenticated
    user.save!

    visit admin_user_path(user)

    expect(page).to have_content('Role')

    # Remove role by clicking on first delete button with in roles table
    within('#roles') do
      click_on 'Delete'
    end

    expect(page).to have_content(
      I18n.t(
        'app.admin.revoke_role.success',
        :role_name => 'authenticated',
        :user_name => user.display_name))
    expect(user.has_role?(:authenticated)).to eq(false)
  end
end
