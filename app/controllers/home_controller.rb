# Site landing page controller
class HomeController < ApplicationController
  def index
    authorize :home_controller, :index?

    Analytics.track(
      :user_id => current_user.email,
      :event => 'View Home Page',
      :properties => {})
  end
end
