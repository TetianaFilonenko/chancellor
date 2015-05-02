module Chancellor
  # An entity is a representation of an organization.
  #
  # Entities can be any kind of organization, customer, vendor, etc.
  class Entity < ActiveRecord::Base
    acts_as_paranoid

    belongs_to :parent_entity, :class_name => Entity
    has_many :contacts
    has_many :locations, :inverse_of => :entity
    has_one :customer
    has_one :salesperson
    has_one :vendor

    validate :parent_is_not_self, :parent_is_not_child
    validates \
      :is_active,
      :name,
      :cached_long_name,
      :reference,
      :uuid,
      :presence => true
    validates :reference, :uniqueness => true

    class << self
      # Get the next reference value in sequence.
      def next_reference
        ((Entity.lock.pluck(:reference).max || '0').to_i + 1).to_s
      end
    end

    def active?
      is_active == 1
    end

    def to_s
      name
    end

    protected

    def parent_is_not_self
      return if parent_entity.nil? || parent_entity != self

      errors.add(:parent_entity, "can't be itself")
    end

    def parent_is_not_child
      return if parent_entity.nil? \
        || parent_entity == self \
        || parent_entity.parent_entity.nil?

      errors.add(:parent_entity, "can't be a child")
    end
  end
end
