# Controller for managing Entity base details.
class EntitiesController < ApplicationController
  before_action :find_entity, :only => [:destroy, :edit, :show, :update]
  # before_action :new_entity, :only => [:create, :new]
  before_action :new_entity_entry, :only => [:create, :new]
  before_action -> { authorize :entity }, :except => :show
  before_action -> { authorize @entity }, :only => :show

  def create
    return render :new unless @entity_entry.valid?

    context = CreateEntity.call(@entity_entry.to_h.merge(:user => current_user))

    if context.success?
      redirect_with_notice(
        entity_path(context.entity),
        t('ar.success.messages.created', :model => t('ar.models.entity')))
    else
      render :new
    end
  end

  def destroy
    if @entity.destroy
      redirect_with_notice(
        entities_path,
        t('ar.success.messages.deleted', :model => t('ar.models.entity')))
    else
      redirect_with_alert(
        entity_path(@entity),
        t('ar.failure.messages.deleted', :model => t('ar.models.entity')))
    end
  end

  def edit; end

  def index
    @search = Entity.search(params[:q])
    @entities = @search.result.decorate
  end

  def new; end

  def show
    Analytics.track(
      :user_id => current_user.email,
      :event => 'View Entity',
      :properties => { :reference => @entity.reference, :name => @entity.name })
  end

  def update
    if @entity.update_attributes(entity_params)
      redirect_with_notice(
        entity_path(@entity),
        t('ar.success.messages.updated', :model => t('ar.models.entity')))
    else
      render :edit
    end
  end

  protected

  def entity_params
    params
      .require(:entity)
      .permit(:display_name, :name, :reference)
  rescue ActionController::ParameterMissing; {}
  end

  def new_entity
    @new_entity = NewEntity.new(new_entity_params)
  end

  def new_entity_entry
    @entity_entry = EntityEntry.new(entity_params)
  end

  def new_entity_params
    params
      .require(:new_entity)
      .permit(
        :name, :reference,
        :street_address, :city, :region, :region_code, :country)
  rescue ActionController::ParameterMissing; {}
  end

  def edit_entity_params
    params
      .require(:entity)
      .permit(:name, :display_name, :reference)
  rescue ActionController::ParameterMissing; {}
  end

  def find_entity
    @entity = Entity.find(params[:id]).decorate
  end
end
