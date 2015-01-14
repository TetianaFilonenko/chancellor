# Admin module
module Admin
  # Admin users helper
  module UsersHelper
    def user_active_string(user)
      user.active? ? 'Active' : 'Inactive'
    end
  end
end
