# Application level helpers.
module ApplicationHelper
  def return_url(default_url)
    return default_url unless params[:return_url]

    if params[:return_url]
      if http_url?(params[:return_url])
        URI.parse(params[:return_url]).to_s
      else
        # REVIEW: Consider logging this
        fail 'None HTTP return url detected, possible XSS attempt.'
      end
    end
  rescue
    default_url
  end

  protected

  def http_url?(url)
    URI.parse(url).class.name.include?('HTTP')
  end
end
