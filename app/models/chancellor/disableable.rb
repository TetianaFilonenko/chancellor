# Chancellor
module Chancellor
  # Disableable object
  module Disableable
    def active?
      is_active == 1
    end
  end
end
