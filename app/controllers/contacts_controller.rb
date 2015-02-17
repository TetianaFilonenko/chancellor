# Controller for managing +Contact+ details.
class ContactsController < ApplicationController
  before_action :load_entity, :only => [:create, :new]
  before_action :load_contact, :only => [:destroy, :edit, :show, :update]
  before_action :new_contact_entry, :only => [:create, :new]
  before_action -> { authorize :contact },
                :only => [:create, :edit, :new, :update]
  before_action -> { authorize @contact }, :only => [:destroy, :show]

  def create
    return render :new unless @contact_entry.valid?

    context = CreateContact.call(
      @contact_entry.to_h.merge(:entity => @entity, :user => current_user))

    if context.success?
      redirect_with_notice(
        entity_path(@entity),
        t('ar.success.messages.created', :model => t('ar.models.contact')))
    else
      render :new
    end
  end

  def destroy
    if @contact.destroy
      redirect_with_notice(
        entity_path(@contact.entity),
        t('ar.success.messages.deleted', :model => t('ar.models.contact')))
    else
      redirect_with_alert(
        entity_path(@contact.entity),
        t('ar.failure.messages.deleted', :model => t('ar.models.contact')))
    end
  end

  def edit; end

  def new; end

  def show; end

  def update
    if @contact.update_attributes(contact_params)
      redirect_with_notice(
        entity_path(@contact.entity),
        t('ar.success.messages.updated', :model => t('ar.models.contact')))
    else
      render :edit
    end
  end

  protected

  def load_entity
    @entity = Entity.find(params[:entity_id])
  end

  def load_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params
      .require(:contact)
      .permit(param_names)
  rescue ActionController::ParameterMissing; {}
  end

  def param_names
    [
      :first_name,
      :last_name,
      :display_name,
      :email_address,
      :fax_number,
      :mobile_number,
      :phone_number,
      :title
    ]
  end

  def new_contact_entry
    @contact_entry = ContactEntry.new(contact_params)
  end
end
