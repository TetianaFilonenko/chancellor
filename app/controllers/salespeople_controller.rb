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

  def edit; end

  def new; end

  def update
    return render :edit unless @salesperson_entry.valid?

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
    @salesperson = Salesperson.find(params[:id])
  end

  def assign_new_salesperson_entry
    @salesperson_entry = SalespersonEntry.new(salesperson_params)
  end

  def assign_edit_salesperson_entry
    hash =
      @salesperson
      .attributes
      .symbolize_keys
      .slice(:default_location_id, :gender, :is_active, :phone, :reference)
      .merge(salesperson_params)
    @salesperson_entry = SalespersonEntry.new(hash)
  end

  def salesperson_params
    params
      .require(:salesperson_entry)
      .permit(:gender,
              :is_active,
              :default_location_id,
              :phone,
              :reference)
  rescue ActionController::ParameterMissing; {}
  end
end
