require 'interactor_creator'
require 'interactor_localized'

# Update an existing +Entity+ +Salesperson+
class UpdateSalesperson
  include Interactor
  include Interactor::Localized

  before :load_salesperson
  before :update_salesperson
  before :validate

  delegate :entity, :to => :context
  delegate :salesperson, :to => :context
  delegate :user, :to => :context

  def call
    salesperson.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.salesperson'))
  end

  def load_salesperson
    context.salesperson = Salesperson.find_by!(:entity_id => entity.id)
  end

  def persist!
    salesperson.save!
  end

  def sales_person_params
    context
      .to_h
      .slice(:entity,
             :default_location,
             :gender,
             :is_active,
             :reference,
             :phone)
  end

  def update_salesperson
    salesperson.assign_attributes(sales_person_params)
  end

  def validate
    return if salesperson.valid?

    context.fail!(:message => 'Invalid details')
  end
end
