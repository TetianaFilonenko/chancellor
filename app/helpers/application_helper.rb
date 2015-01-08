# Application level helpers.
module ApplicationHelper
  def return_url(default_url)
    return default_url unless params[:return_url]

    if params[:return_url]
      if URI.parse(params[:return_url]).class.name.include?('HTTP')
        URI.parse(params[:return_url]).to_s
      else
        # REVIEW: Consider logging this
        fail 'None HTTP return url detected, possible XSS attempt.'
      end
    end
  rescue
    default_url
  end
end
