require 'devise'

include Warden::Test::Helpers
Warden.test_mode!

# Controller helpers
module ControllerHelpers
  # rubocop:disable Metrics/AbcSize
  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!)
        .and_throw(:warden, :scope => :user)
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
  # rubocop:enable Metrics/AbcSize
end

# Feature helpers
module FeatureHelpers
  def sign_in(user = double('user'))
    login_as(user, :scope => :user)
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerHelpers, :type => :controller
  config.include FeatureHelpers, :type => :feature
end
