# LocationsHelper
module LocationsHelper
  def edit_location_link(location, return_url, options)
    link_to 'Edit',
            edit_location_path(location, :return_url => return_url),
            options
  end
end
