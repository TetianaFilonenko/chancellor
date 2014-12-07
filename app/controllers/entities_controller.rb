class EntitiesController < ApplicationController
  before_filter :set_entity, :only => [:show]

  def create
    interactor = CreateEntity.call(entity_params)
    @entity = interactor.entity

    if interactor.success?
      redirect_with_notice(entity_path(@entity), 'Entity was successfully created')
    else
      render :new
    end
  end

  def index
    @search = Entity.search(params[:q])
    @entities = @search.result.decorate
  end

  def new
    @entity = Entity.new
  end

  protected

  def entity_params
    params.
      require(:entity).
      permit(:name, :reference, :street_address, :city, :region, :region_code, :country)
  end

  def set_entity
    @entity = Entity.find(params[:id]).decorate
  end
end
