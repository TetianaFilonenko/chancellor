require 'interactor_localized'

# Updates an existing +Entity+
class UpdateEntity
  include Interactor
  include Interactor::Localized

  before :load_entity
  before :update_entity
  before :validate

  delegate :entity, :to => :context
  delegate :user, :to => :context

  def call
    entity.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.entity'))
  end

  protected

  def load_entity
    context.entity = Entity.find_by!(:id => context.entity_id)
  end

  def update_entity
    entity.assign_attributes(update_params)
  end

  def update_params
    context
      .to_h
      .slice(:display_name,
             :is_active,
             :name,
             :parent_entity_id,
             :reference)
  end

  def persist!
    entity.save!
  end

  def validate
    return if entity.valid?

    context.fail!(:message =>
      t('ar.failure.messages.validate', :model => t('ar.models.entity')))
  end
end
