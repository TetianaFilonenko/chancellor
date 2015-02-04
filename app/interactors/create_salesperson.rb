require 'interactor_creator'
require 'interactor_localized'

# Create a new +Entity+ +Salesperson+
class CreateSalesperson
  include Interactor
  include Interactor::Creator
  include Interactor::Localized

  delegate :location, :to => :context
  delegate :salesperson, :to => :context
  delegate :user, :to => :context

  def call
    salesperson.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.created', :model => t('ar.models.salesperson'))
  end

  def after_build
    return if location.nil?

    context.default_location =
      DefaultLocation.new(:entity => salesperson, :location => location)
    salesperson.default_location = context.default_location
  end

  def before_build
    context.location = Location.find_by(:id => context.location_id)
  end

  def build_params
    base_params
      .slice(:entity, :gender, :reference, :phone)
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
