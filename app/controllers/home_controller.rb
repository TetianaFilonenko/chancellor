class HomeController < ApplicationController
  def index
    authorize :home_controller, :index?
  end
end
