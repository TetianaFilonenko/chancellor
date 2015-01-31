# Salespeople helper methods.
module SalespeopleHelper
  def location_string(salesperson)
    return nil if salesperson.location.nil?

    salesperson.location.decorate.long_address
  end
end
