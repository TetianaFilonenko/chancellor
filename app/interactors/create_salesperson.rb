require 'interactor_creator'
require 'interactor_localized'

# Create a new +Entity+ +Salesperson+
class CreateSalesperson
  include Interactor
  include Interactor::Creator
  include Interactor::Localized

  delegate :salesperson, :to => :context
  delegate :user, :to => :context

  def call
    salesperson.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.created', :model => t('ar.models.salesperson'))
  end

  def build_params
    base_params
      .slice(:entity,
             :default_location_id,
             :gender,
             :is_active,
             :reference,
             :phone)
      .merge(:uuid => UUID.generate(:compact))
  end

  def persist!
    salesperson.save!
  end

  def validate
    return if salesperson.valid?

    context.fail!(:message => 'Invalid details')
  end
end
