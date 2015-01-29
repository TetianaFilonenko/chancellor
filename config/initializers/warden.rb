Warden::Manager.after_authentication do |user, _auth, _opts|
  Analytics.identify(
    :user_id => user.email,
    :traits => {
      :name => user.display_name,
      :email => user.email,
      :created_at => DateTime.now
    })
end
