# User
class User
  # User Role
  class Role < ActiveRecord::Base
    belongs_to :user

    validates_presence_of :name
    validates_presence_of :user
  end
end
