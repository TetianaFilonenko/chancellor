module Entities
  # Controller for viewing the change history for an +Entity+.
  class VersionsController < ApplicationController
    before_action :find_entity, :only => :index
    before_action -> { authorize @entity }, :only => :index

    def index
      @entity_versions = []

      return if @entity.versions.size == 1

      @entity_versions = hashed_entity_versions
    end

    def find_entity
      @entity = Entity.find(params[:id])
    end

    def hashed_entity_versions
      @entity
        .versions
        .drop(1)
        .each_with_object({}) { |v, memo| memo[v] = v.reify.decorate }
    end
  end
end
