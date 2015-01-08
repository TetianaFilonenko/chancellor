# Represents a user of the system.
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable,
         :database_authenticatable,
         # :registerable,
         :recoverable,
         :rememberable, :trackable, :validatable
  has_many :roles, :autosave => true, :class => Role

  validates_presence_of :is_active

  def has_role?(*role_list)
    self.roles.where { name.in my { role_list.map(&:to_s) } }.any?
  end

  def is_active?
    is_active == 1
  end
end
