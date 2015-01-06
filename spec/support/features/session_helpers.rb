# Feature helpers
module FeatureHelpers
  # User session
  module Session
    def sign_in_with(email, password)
      visit '/users/sign_in'
      fill_in 'Email', :with => email
      fill_in 'Password', :with => password
      click_button 'Log in'
    end
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers::Session, :type => :feature
end
