require 'interactor_creator'
require 'interactor_localized'

# Creates a new +Vendor+
class CreateVendor
  include Interactor
  include Interactor::Creator
  include Interactor::Localized

  delegate :vendor, :to => :context
  delegate :user, :to => :context

  def call
    vendor.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.created', :model => t('ar.models.vendor'))
  end

  protected

  def build_params
    base_params
      .slice(:entity,
             :default_contact_id,
             :default_location_id,
             :reference)
      .merge(:uuid => UUID.generate(:compact))
  end

  def persist!
    vendor.save!
  end
end
