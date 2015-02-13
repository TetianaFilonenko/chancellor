require 'interactor_creator'
require 'interactor_localized'

# Creates a new +Customer+
class CreateCustomer
  include Interactor
  include Interactor::Creator
  include Interactor::Localized

  delegate :customer, :to => :context
  delegate :user, :to => :context

  def call
    customer.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.created', :model => t('ar.models.customer'))
  end

  protected

  def build_params
    base_params
      .slice(:entity,
             :default_contact_id,
             :default_location_id,
             :reference,
             :salesperson_id)
      .merge(:uuid => UUID.generate(:compact))
  end

  def persist!
    customer.save!
  end
end
