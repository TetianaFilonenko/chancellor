# Policy to control access to the HomeController
class HomeControllerPolicy < Struct.new(:user, :home_controller)
  def index?
    user
  end
end
