# User role
class Role < ActiveRecord::Base
  ROLE_NAMES = %w(
    admin
    authenticated
    contact_read
    contact_write
    customer_read
    customer_write
    entity_admin
    entity_user
    entity_read
    entity_write
    location_read
    location_write
    salesperson_read
    salesperson_write
    salesperson_admin
    salesperson_user
    user_admin)

  # rubocop:disable HasAndBelongsToMany
  has_and_belongs_to_many :users, :join_table => :users_roles
  # rubocop:enable HasAndBelongsToMany
  belongs_to :resource, :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify
end
