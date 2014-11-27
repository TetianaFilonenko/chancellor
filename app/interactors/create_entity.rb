class CreateEntity
  include Interactor

  before :create_entity
  before :validate

  def call
    if context.entity.save
      context.message = 'Entity successfully created'
    else
      fail!(:message => 'Entity not created')
    end
  end

  def create_entity
    context.entity = Entity.new(context.to_h)
    context.entity.uuid = UUID.generate(:compact)
  end

  def validate
    unless context.entity.valid?
      context.fail!(:message => 'Invalid Entity details')
    end
  end
end
