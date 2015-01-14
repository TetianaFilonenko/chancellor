# Admin
module Admin
  # User roles helper
  module UserRolesHelper
    def roles_collection(role_names = Role::ROLE_NAMES)
      role_names.map do |role_name|
        [role_name.humanize, role_name]
      end
    end
  end
end
