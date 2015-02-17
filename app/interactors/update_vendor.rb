require 'interactor_localized'

# Updates an existing +Vendor+
class UpdateVendor
  include Interactor
  include Interactor::Localized

  before :load_vendor
  before :update_vendor
  before :validate

  delegate :vendor, :to => :context
  delegate :entity, :to => :context
  delegate :user, :to => :context

  def call
    vendor.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.vendor'))
  end

  protected

  def load_vendor
    context.vendor = Vendor.find_by!(:entity_id => entity.id)
  end

  def update_vendor
    vendor.assign_attributes(update_params)
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
    vendor.save!
  end

  def validate
    return if vendor.valid?

    context.fail!(:message =>
      t('ar.failure.messages.validate', :model => t('ar.models.vendor')))
  end
end
