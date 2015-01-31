# Controller for managing Entity base details.
class EntitiesController < ApplicationController
  before_action :find_entity, :only => [:destroy, :edit, :show, :update]
  before_action :new_entity, :only => [:create, :new]
  before_action -> { authorize :entity }, :except => :show
  before_action -> { authorize @entity }, :only => :show

  def create
    return render :new unless @new_entity.valid?

    interactor = CreateEntity.call(@new_entity.to_h)

    if interactor.success?
      redirect_with_notice(
        entity_path(interactor.entity),
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
    if @entity.update_attributes(edit_entity_params)
      redirect_with_notice(
        entity_path(@entity),
        'Entity was successfully saved')
    else
      render :edit
    end
  end

  protected

  def new_entity
    @new_entity = NewEntity.new(new_entity_params)
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
    if params[:version]
      @entity = Entity.find_version(params[:version])
    else
      @entity = Entity.find(params[:id])
    end
    @entity = @entity.decorate
  end
end
