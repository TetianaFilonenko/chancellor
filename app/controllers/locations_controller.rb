# Controller for managing locations.
class LocationsController < ApplicationController
  before_action :load_entity, :only => [:create, :new]
  before_action :load_location, :only => [:destroy, :edit, :show, :update]
  before_action :new_location_entry, :only => [:create, :new]
  before_action -> { authorize :location },
                :only => [:create, :edit, :new, :update]
  before_action -> { authorize @location }, :only => [:destroy, :show]

  def create
    return render :new unless @location_entry.valid?

    context = CreateLocation.call(
      @location_entry.to_h.merge(:entity => @entity, :user => current_user))

    if context.success?
      redirect_with_notice(
        entity_path(@entity),
        t('ar.success.messages.created', :model => t('ar.models.location')))
    else
      render :new
    end
  end

  def destroy
    if @location.destroy
      redirect_with_notice(
        entity_path(@location.entity),
        t('ar.success.messages.deleted', :model => t('ar.models.location')))
    else
      redirect_with_alert(
        entity_path(@location.entity),
        t('ar.failure.messages.deleted', :model => t('ar.models.location')))
    end
  end

  def edit; end

  def new; end

  def show; end

  def update
    if @location.update_attributes(location_params)
      redirect_with_notice(
        entity_path(@location.entity),
        t('ar.success.messages.updated', :model => t('ar.models.location')))
    else
      render :edit
    end
  end

  protected

  def load_entity
    @entity = Entity.find(params[:entity_id])
  end

  def load_location
    @location = Location.find(params[:id])
  end

  def location_params
    params
      .require(:location)
      .permit(
        :location_name,
        :street_address,
        :city,
        :region,
        :region_code,
        :country)
  rescue ActionController::ParameterMissing; {}
  end

  def new_location_entry
    @location_entry = LocationEntry.new(location_params)
  end
end
