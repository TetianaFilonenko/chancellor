require 'interactor_creator'
require 'interactor_localized'

# Create a new +Entity+
class CreateEntity
  include Interactor
  include Interactor::Creator
  include Interactor::Localized

  delegate :entity, :to => :context
  delegate :user, :to => :context

  def call
    entity.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.entity'))
  end

  def after_build
    entity.primary_location = context.location
    entity.display_name ||= entity.name
    entity.cached_long_name = entity.decorate.long_name
  end

  def build
    context.entity = Entity.new(entity_params)
    context.location = Location.new(
      location_params.merge(:entity => entity, :location_name => entity.name))
  end

  def build_params
    {}
  end

  def entity_params
    base_params
      .slice(:name, :reference)
      .merge(:uuid => UUID.generate(:compact))
  end

  def location_params
    base_params
      .slice(:street_address, :city, :region, :region_code, :country)
      .merge(:uuid => UUID.generate(:compact))
  end

  def persist!
    context.entity.save!
    context.location.save!
  end

  def validate
    return if context.entity.valid? && context.location.valid?

    context.fail!(:message => 'Invalid details')
  end
end
