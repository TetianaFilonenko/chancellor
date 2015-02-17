require 'interactor_localized'

# Updates an existing +Customer+
class UpdateCustomer
  include Interactor
  include Interactor::Localized

  before :load_customer
  before :update_customer
  before :validate

  delegate :customer, :to => :context
  delegate :entity, :to => :context
  delegate :user, :to => :context

  def call
    customer.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.customer'))
  end

  protected

  def load_customer
    context.customer = Customer.find_by!(:entity_id => entity.id)
  end

  def update_customer
    customer.assign_attributes(update_params)
  end

  def update_params
    context
      .to_h
      .slice(:default_contact_id,
             :default_location_id,
             :is_active,
             :reference,
             :salesperson_id)
  end

  def persist!
    customer.save!
  end

  def validate
    return if customer.valid?

    context.fail!(:message =>
      t('ar.failure.messages.validate', :model => t('ar.models.customer')))
  end
end
