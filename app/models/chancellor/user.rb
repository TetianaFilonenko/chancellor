# Represents a user of the system.
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable,
         :database_authenticatable,
         # :registerable,
         :recoverable,
         :rememberable, :trackable, :validatable
  rolify

  validates :is_active, :presence => true

  def active?
    is_active == 1
  end

  def available_roles
    Role::ROLE_NAMES - roles.map(&:name)
  end
end
