# EntitiesHelper
module EntitiesHelper
  def edit_entity_link(entity, return_url, options)
    link_to 'Edit',
            edit_entity_path(entity, :return_url => return_url),
            options
  end
end
