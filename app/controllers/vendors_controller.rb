# Controller for maintaining +Vendor+ details.
class VendorsController < ApplicationController
  before_action :load_vendor, :only => [:destroy, :edit, :update]
  before_action :load_entity
  before_action :new_vendor_entry
  before_action :load_contacts
  before_action :load_locations
  before_action -> { authorize :vendor }, :except => :show
  before_action -> { authorize @vendor }, :only => [:edit, :show, :update]

  def create
    return render :new unless @vendor_entry.valid?

    context = CreateVendor.call(vendor_hash)

    if context.success?
      redirect_with_notice(entity_path(context.entity), context.message)
    else
      render :new
    end
  end

  def destroy
    if @vendor.destroy
      redirect_with_notice(
        entity_path(@entity),
        t('ar.success.messages.deleted', :model => t('ar.models.vendor')))
    else
      redirect_with_alert(
        entity_path(@entity),
        t('ar.failure.messages.deleted', :model => t('ar.models.vendor')))
    end
  end

  def edit; end

  def new; end

  def update
    return render :edit unless @vendor_entry.valid?

    context = UpdateVendor.call(vendor_hash)

    if context.success?
      redirect_with_notice(entity_path(context.entity), context.message)
    else
      render :edit
    end
  end

  protected

  def new_vendor_entry
    hash =
      (@vendor || Vendor.new)
      .attributes
      .symbolize_keys
      .slice(:default_contact_id,
             :default_location_id,
             :is_active,
             :reference)
    @vendor_entry = VendorEntry.new(hash.merge(vendor_params))
  end

  def vendor_hash
    @vendor_entry
      .to_h
      .slice(:default_contact_id,
             :default_location_id,
             :is_active,
             :reference)
      .merge(:entity => @entity, :user => current_user)
  end

  def vendor_params
    params
      .require(:vendor_entry)
      .permit(:default_contact_id,
              :default_location_id,
              :is_active,
              :reference)
  rescue ActionController::ParameterMissing; {}
  end

  def load_entity
    return @entity = @vendor.entity if @vendor

    @entity = Entity.find(params[:entity_id])
  end

  def load_contacts
    @contacts = Contact.where { entity_id == my { @entity.id } }
  end

  def load_locations
    @locations = Location.where { entity_id == my { @entity.id } }.decorate
  end

  def load_vendor
    @vendor = Vendor.find(params[:id])
  end
end
