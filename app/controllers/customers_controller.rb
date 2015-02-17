# Controller for maintaining +Customer+ details.
class CustomersController < ApplicationController
  before_action :load_customer, :only => [:destroy, :edit, :update]
  before_action :load_entity
  before_action :new_customer_entry
  before_action :load_contacts
  before_action :load_locations
  before_action :load_salespeople
  before_action -> { authorize :customer }, :except => :show
  before_action -> { authorize @customer }, :only => [:edit, :show, :update]

  def create
    return render :new unless @customer_entry.valid?

    context = CreateCustomer.call(customer_hash)

    if context.success?
      redirect_with_notice(entity_path(context.entity), context.message)
    else
      render :new
    end
  end

  def destroy
    if @customer.destroy
      redirect_with_notice(
        entity_path(@entity),
        t('ar.success.messages.deleted', :model => t('ar.models.customer')))
    else
      redirect_with_alert(
        entity_path(@entity),
        t('ar.failure.messages.deleted', :model => t('ar.models.customer')))
    end
  end

  def edit; end

  def new; end

  def update
    return render :edit unless @customer_entry.valid?

    context = UpdateCustomer.call(customer_hash)

    if context.success?
      redirect_with_notice(entity_path(context.entity), context.message)
    else
      render :edit
    end
  end

  protected

  def new_customer_entry
    hash =
      (@customer || Customer.new)
      .attributes
      .symbolize_keys
      .slice(:default_contact_id,
             :default_location_id,
             :is_active,
             :reference,
             :salesperson_id)
    @customer_entry = CustomerEntry.new(hash.merge(customer_params))
  end

  def customer_hash
    @customer_entry
      .to_h
      .slice(:default_contact_id,
             :default_location_id,
             :is_active,
             :reference,
             :salesperson_id)
      .merge(:entity => @entity, :user => current_user)
  end

  def customer_params
    params
      .require(:customer_entry)
      .permit(:default_contact_id,
              :default_location_id,
              :is_active,
              :reference,
              :salesperson_id)
  rescue ActionController::ParameterMissing; {}
  end

  def load_entity
    return @entity = @customer.entity if @customer

    @entity = Entity.find(params[:entity_id])
  end

  def load_contacts
    @contacts =
      Contact.where { entity_id == my { @entity.id } }
  end

  def load_locations
    @locations =
      Location.where { entity_id == my { @entity.id } }.map(&:decorate)
  end

  def load_customer
    @customer = Customer.find(params[:id])
  end

  def load_salespeople
    @salespeople = Salesperson.active
  end
end
