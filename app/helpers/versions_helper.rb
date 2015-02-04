# VersionsHelper
module VersionsHelper
  def versions_link(item_type, item, return_url, options)
    return nil if item.nil? || item.deleted?

    link_to 'Versions',
            versions_path(
              item_type,
              item.id,
              :return_url => return_url || request.original_url),
            options
  end
end
