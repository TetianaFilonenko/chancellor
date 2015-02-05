require 'interactor_creator'
require 'interactor_localized'

# Create a new +Location+
class CreateLocation
  include Interactor
  include Interactor::Creator
  include Interactor::Localized

  delegate :entity, :to => :context
  delegate :location, :to => :context
  delegate :user, :to => :context

  def call
    entity.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.location'))
  end

  def build_params
    base_params
      .slice(:location_name,
             :street_address,
             :city,
             :region,
             :region_code,
             :country)
      .merge(:uuid => UUID.generate(:compact))
      .merge(:entity => entity)
  end

  def persist!
    location.save!
  end

  def validate
    return if location.valid?

    context.fail!(:message => 'Invalid details')
  end
end
