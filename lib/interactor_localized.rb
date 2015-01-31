# Interactor
module Interactor
  # Interactor localization support.
  module Localized
    extend ActiveSupport::Concern

    included do
      def t(*args)
        I18n.t(*args)
      end
    end
  end
end
