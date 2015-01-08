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

  validates :is_active, :presence => true

  def role?(*role_list)
    roles.where { name.in my { role_list.map(&:to_s) } }.any?
  end

  def active?
    is_active == 1
  end
end
