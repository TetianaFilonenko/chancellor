# Controller for maintaining +Salesperson+ details.
class SalespeopleController < ApplicationController
  before_action :load_salesperson, :only => [:destroy, :edit, :update]
  before_action :load_entity
  before_action :assign_new_salesperson_entry, :only => [:create, :new]
  before_action :assign_edit_salesperson_entry, :only => [:edit, :update]
  before_action :load_locations
  before_action -> { authorize :salesperson }, :except => :show
  before_action -> { authorize @salesperson }, :only => [:edit, :show, :update]

  def create
    return render :new unless @salesperson_entry.valid?

    context = CreateSalesperson.call(
      @salesperson_entry.to_h.merge(:entity => @entity, :user => current_user))

    if context.success?
      redirect_with_notice(entity_path(context.entity), context.message)
    else
      render :new
    end
  end

  def destroy
    if @salesperson.destroy
      redirect_with_notice(
        entity_path(@entity),
        t('ar.success.messages.deleted', :model => t('ar.models.salesperson')))
    else
      redirect_with_alert(
        entity_path(@entity),
        t('ar.failure.messages.deleted', :model => t('ar.models.salesperson')))
    end
  end

  def edit; end

  def new; end

  def update
    return render :new unless @salesperson_entry.valid?

    context = UpdateSalesperson.call(
      @salesperson_entry.to_h.merge(:entity => @entity, :user => current_user))

    if context.success?
      redirect_with_notice(entity_path(context.entity), context.message)
    else
      render :edit
    end
  end

  protected

  def find_entity
    @entity = Entity.find(params[:entity_id])
  end

  def load_entity
    return @entity = @salesperson.entity if @salesperson

    @entity = Entity.find(params[:entity_id])
  end

  def load_locations
    @locations =
      Location.where { entity_id == my { @entity.id } }.map(&:decorate)
  end

  def load_salesperson
    @salesperson = Salesperson.with_deleted.find(params[:id])
  end

  def assign_new_salesperson_entry
    @salesperson_entry = SalespersonEntry.new(salesperson_params)
  end

  def assign_edit_salesperson_entry
    hash =
      @salesperson
      .attributes
      .symbolize_keys
      .slice(:gender, :phone, :reference)
      .merge(:location_id => @salesperson.location.try(:id))
      .merge(:is_deleted => @salesperson.deleted? ? 1 : 0)
      .merge(salesperson_params)
    @salesperson_entry = SalespersonEntry.new(hash)
  end

  def salesperson_params
    params
      .require(:salesperson_entry)
      .permit(:gender,
              :is_deleted,
              :location_id,
              :phone,
              :reference)
  rescue ActionController::ParameterMissing; {}
  end
end
