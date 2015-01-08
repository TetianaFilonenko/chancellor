class HomeControllerPolicy < Struct.new(:user, :home_controller)
  def index?
    user
  end
end
