# EntityDecorator
class EntityDecorator < Draper::Decorator
  delegate_all

  def display_string
    long_name
  end

  def long_address
    primary_location.decorate.long_address
  end

  def long_name
    "#{reference} - \
#{display_name}, \
#{primary_location.decorate.long_address}"
  end
end
