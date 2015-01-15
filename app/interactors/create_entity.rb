require 'interactor_creator'

# Create a new +Entity
class CreateEntity
  include Interactor
  include Interactor::Creator

  def call
    if context.entity.save
      context.message = 'Entity successfully created'
    else
      context.fail!(:message => 'Entity not created')
    end
  end

  def after_build
    context.entity.display_name ||= context.entity.name
    context.entity.cached_long_name = context.entity.decorate.long_name
  end

  def build_params
    base_params.merge(:uuid => UUID.generate(:compact))
  end
end
