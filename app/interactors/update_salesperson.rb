require 'interactor_creator'
require 'interactor_localized'

# Update an existing +Entity+ +Salesperson+
class UpdateSalesperson
  include Interactor
  include Interactor::Localized

  before :load_location
  before :load_salesperson
  before :update_salesperson
  before :update_location
  before :validate

  delegate :entity, :to => :context
  delegate :location, :to => :context
  delegate :salesperson, :to => :context
  delegate :user, :to => :context

  def call
    salesperson.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.salesperson'))
  end

  def load_location
    context.location = Location.find_by(:id => context.location_id)
  end

  def load_salesperson
    context.salesperson = Salesperson
      .with_deleted
      .find_by!(:entity_id => entity.id)
  end

  def persist!
    salesperson.save!
  end

  def sales_person_params
    context
      .to_h
      .slice(:entity, :gender, :reference, :phone)
  end

  def update_salesperson
    salesperson.restore if context.is_deleted == 0 && salesperson.deleted?

    salesperson.assign_attributes(sales_person_params)
  end

  def update_location
    if salesperson.default_location && location.nil?
      # Destroy keeps a paper_trail record
      salesperson.remove_location
    elsif location
      salesperson.location = location
    end
  end

  def validate
    return if salesperson.valid?

    context.fail!(:message => 'Invalid details')
  end
end
