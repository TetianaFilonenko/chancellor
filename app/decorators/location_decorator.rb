# LocationDecorator
class LocationDecorator < Draper::Decorator
  delegate_all

  def address_lines
    [street_address, city, region, region_code, country].compact
  end

  def long_address
    address_lines.join(', ')
  end
end
