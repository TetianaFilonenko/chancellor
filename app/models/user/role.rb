# User
class User
  # User Role
  class Role < ActiveRecord::Base
    belongs_to :user

    validates \
      :name,
      :user,
      :presence => true
  end
end
