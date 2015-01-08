class EntitiesController < ApplicationController
  before_filter :set_entity, :only => [:destroy, :edit, :show, :update]
  before_filter -> { authorize :entity }, :except => :show
  before_filter -> { authorize @entity }, :only => :show

  def create
    interactor = CreateEntity.call(entity_params)
    @entity = interactor.entity

    if interactor.success?
      redirect_with_notice(
        entity_path(@entity),
        'Entity was successfully created')
    else
      render :new
    end
  end

  def destroy
    if @entity.destroy
      redirect_with_notice(entities_path, 'Entity was successfully deleted')
    else
      redirect_with_alert(entity_path(@entity), 'Entity was not deleted')
    end
  end

  def edit
  end

  def index
    @search = Entity.search(params[:q])
    @entities = @search.result.decorate
  end

  def new
    @entity = Entity.new
  end

  def update
    if @entity.update_attributes(entity_params)
      redirect_with_notice(
        entity_path(@entity),
        'Entity was successfully saved')
    else
      render :edit
    end
  end

  protected

  def entity_params
    params.
      require(:entity).
      permit(
        :name,
        :reference,
        :street_address,
        :city,
        :region,
        :region_code,
        :country)
  rescue ActionController::ParameterMissing ; {}
  end

  def set_entity
    @entity = Entity.find(params[:id]).decorate
  end
end
