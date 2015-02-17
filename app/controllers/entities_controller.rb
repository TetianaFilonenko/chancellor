# Controller for managing Entity base details.
class EntitiesController < ApplicationController
  before_action :find_entity, :only => [:destroy, :edit, :show, :update]
  before_action :build_entity_entry, :except => [:destroy, :index, :show]
  before_action -> { authorize :entity }, :except => :show
  before_action -> { authorize @entity }, :only => :show

  def create
    return render :new unless @entity_entry.valid?

    context = CreateEntity.call(entity_hash)

    if context.success?
      redirect_with_notice(
        entity_path(context.entity),
        t('ar.success.messages.created', :model => t('ar.models.entity')))
    else
      render :new
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
    return render :edit unless @entity_entry.valid?

    context = UpdateEntity.call(entity_hash.merge(:entity_id => @entity.id))

    if context.success?
      redirect_with_notice(entity_path(context.entity), context.message)
    else
      render :edit
    end
  end

  protected

  def build_entity_entry
    @entity_entry = EntityEntry.build_from_entity(@entity || Entity.new)
    @entity_entry.merge_hash(entity_params)
  end

  def entity_hash
    @entity_entry
      .to_h
      .slice(:display_name,
             :parent_entity_id,
             :name,
             :is_active,
             :reference)
      .merge(:user => current_user)
  end

  def entity_params
    params
      .require(:entity_entry)
      .permit(:display_name,
              :parent_entity_id,
              :name,
              :is_active,
              :reference)
  rescue ActionController::ParameterMissing; {}
  end

  def find_entity
    @entity = Entity.find(params[:id])
  end
end
