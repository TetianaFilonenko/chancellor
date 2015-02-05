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
    entity.display_name ||= entity.name
    entity.cached_long_name = entity.decorate.long_name
  end

  # def build
  #   context.entity = Entity.new(entity_params)
  # end

  def build_params
    base_params
      .slice(:name, :reference)
      .merge(:uuid => UUID.generate(:compact))
  end

  # def entity_params
  #   base_params
  #     .slice(:name, :reference)
  #     .merge(:uuid => UUID.generate(:compact))
  # end

  def persist!
    entity.save!
  end

  def validate
    return if context.entity.valid?

    context.fail!(:message => 'Invalid details')
  end
end
