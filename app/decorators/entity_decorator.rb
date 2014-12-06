class EntityDecorator < Draper::Decorator
  delegate_all

  def display_string
    long_name
  end

  def long_name
    "#{reference} - \
#{display_name}, \
#{street_address}, \
#{city}, \
#{region}, \
#{region_code}, \
#{country}"
  end

end
