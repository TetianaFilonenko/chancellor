# NullLocation, not used but provided as an example of a "Null" class.
class NullLocation
  include Draper::Decoratable

  def city
    nil
  end

  def country
    nil
  end

  def decorator_class
    LocationDecorator
  end

  def id
    nil
  end

  def region
    nil
  end

  def region_code
    nil
  end

  def street_address
    nil
  end
end
