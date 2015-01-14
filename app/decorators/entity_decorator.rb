# EntityDecorator
class EntityDecorator < Draper::Decorator
  delegate_all

  def address_lines
    [street_address, city, region, region_code, country].compact
  end

  def display_string
    long_name
  end

  def long_address
    address_lines.join(', ')
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
