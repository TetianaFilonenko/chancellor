class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # We could write some magic using method missing 
  # but I'm not a big fan of magic.
  def redirect_with_notice(url, message)
    redirect_to(url, :notice => message)
  end

  def redirect_with_alert(url, message)
    redirect_to(url, :alert => message)
  end
end
