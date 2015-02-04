# Maps a +Location+ to a type of +Entity+.
class DefaultLocation < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true
  belongs_to :location

  has_paper_trail

  validates \
    :entity,
    :location,
    :presence => true
  validates \
    :location,
    :uniqueness => {
      :scope => [:entity_id, :entity_type]
    }
end
