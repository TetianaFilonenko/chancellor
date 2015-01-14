namespace :chancellor do
  desc 'Creates a new user'
  task(
    :create_user,
    [:email_address, :roles, :password] => :environment) do |_t, args|
    user = User.where { email == args.email_address }.first
    user ||= User.new do |u|
      u.email = args.email_address
      u.password = args[:password]
      u.password_confirmation = args[:password]
      u.skip_confirmation!
    end

    user.save!
  end
end
