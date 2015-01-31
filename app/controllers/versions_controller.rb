# paper_clip versions controller.
class VersionsController < ApplicationController
  before_action :find_model, :only => :index
  before_action :find_model_by_version_id, :only => :show
  before_action -> { authorize @model }, :only => [:show, :index]

  def index
    @versions = []

    return if @model.versions.size == 1

    @versions = hashed_versions
  end

  def show; end

  protected

  def find_model
    @model = klazz.with_deleted.find(params[:item_id])
  end

  def find_model_by_version_id
    @version = PaperTrail::Version.find(params[:id])
    @model = @version.reify
    @item_type = @model.class.name.to_s.underscore
  end

  def klazz
    params[:item_type].camelize.constantize
  end

  def hashed_versions
    @model
      .versions
      .drop(1)
      .each_with_object({}) { |v, memo| memo[v] = v.reify }
  end
end
