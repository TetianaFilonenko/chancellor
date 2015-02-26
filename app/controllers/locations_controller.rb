# Controller for managing locations.
class LocationsController < ApplicationController
  before_action :find_location, :only => [:edit, :show, :update]
  before_action :load_entity, :except => [:index, :show]
  before_action :build_location_entry, :except => [:index, :show]
  before_action -> { authorize :location },
                :only => [:create, :new, :update]
  before_action -> { authorize @location }, :only => [:edit, :show]

  def create
    return render :new unless @location_entry.valid?

    context = CreateLocation.call(location_hash)

    if context.success?
      redirect_with_notice(
        entity_path(@entity),
        t('ar.success.messages.created', :model => t('ar.models.location')))
    else
      render :new
    end
  end

  def edit; end

  def new; end

  def show; end

  def update
    return render :edit unless @location_entry.valid?

    if @location.update_attributes(location_params)
      redirect_with_notice(
        entity_path(@location.entity),
        t('ar.success.messages.updated', :model => t('ar.models.location')))
    else
      render :edit
    end
  end

  protected

  def build_location_entry
    hash =
      (@location || Location.new)
      .attributes
      .symbolize_keys
      .slice(*param_keys)
    @location_entry = LocationEntry.new(hash.merge(location_params))
  end

  def location_hash
    @location_entry
      .to_h
      .slice(*param_keys)
      .merge(:entity => @entity, :user => current_user)
  end

  def load_entity
    return @entity = @location.entity if @location

    @entity = Entity.find(params[:entity_id])
  end

  def find_location
    @location = Location.find(params[:id])
  end

  def location_params
    params
      .require(:location_entry)
      .permit(param_keys)
  rescue ActionController::ParameterMissing; {}
  end

  def param_keys
    [
      :is_active,
      :location_name,
      :street_address,
      :city,
      :region,
      :region_code,
      :country
    ]
  end
end
