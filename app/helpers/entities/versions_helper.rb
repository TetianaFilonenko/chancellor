module Entities
  # VersionsHelper
  module VersionsHelper
    def show_model_version_path(model, version, return_url = nil)
      url_for [
        model,
        :return_url => return_url || request.original_url,
        :version => version.id
      ]
    end
  end
end
