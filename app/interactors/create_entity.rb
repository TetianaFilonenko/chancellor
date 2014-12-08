class CreateEntity
  include Interactor

  before :create
  before :validate

  def call
    if context.entity.save
      context.message = 'Entity successfully created'
    else
      fail!(:message => 'Entity not created')
    end
  end

  def create
    context.entity = Entity.new(context.to_h)
    context.entity.display_name ||= context.entity.name
    context.entity.cached_long_name = context.entity.decorate.long_name
    context.entity.uuid = UUID.generate(:compact)
  end

  def validate
    unless context.entity.valid?
      context.fail!(:message => 'Invalid Entity details')
    end
  end
end
