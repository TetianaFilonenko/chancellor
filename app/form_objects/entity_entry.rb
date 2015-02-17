# Captures +Entity+ information.
class EntityEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :display_name, String
  attribute :is_active, Integer
  attribute :name, String
  attribute :parent_entity_id, Integer
  attribute :parent_entity_id_typeahead, String
  attribute :reference, String

  validates \
    :is_active,
    :name,
    :reference, :presence => true

  class << self
    def build_from_entity(entity)
      hash = entity_hash(entity)

      if entity.parent_entity
        hash[:parent_entity_id_typeahead] =
          entity.parent_entity.cached_long_name
      end

      EntityEntry.new(hash)
    end

    def entity_hash(entity)
      entity
        .attributes
        .symbolize_keys
        .slice(:display_name,
               :is_active,
               :name,
               :parent_entity_id,
               :is_active,
               :reference)
    end
  end

  def merge_hash(hash)
    hash.each do |k, v|
      self[k] = v
    end

    self
  end
end
