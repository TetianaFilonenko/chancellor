# Controller for managing locations.
class LocationsController < ApplicationController
  before_action :load_location, :only => [:edit, :update]
  before_action -> { authorize :location }, :only => [:edit, :update]

  def edit; end

  def update
    if @location.update_attributes(location_params)
      redirect_with_flash(
        entity_path(@location.entity),
        :notice,
        t('ar.success.messages.updated', :model => t('ar.models.location')))
    else
      render :edit
    end
  end

  protected

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
  end
end
