if ENV['smtp_server']
  ActionMailer::Base.smtp_settings = {
    :port => ENV['smtp_port'],
    :address => ENV['smtp_server'],
    :user_name => ENV['smtp_login'],
    :password => ENV['smtp_password'],
    :authentication => :plain
  }
  ActionMailer::Base.delivery_method = :smtp
end

ActionMailer::Base.smtp_settings ||= {}
ActionMailer::Base.smtp_settings.merge!(ENV.to_h.symbolize_keys.slice(:domain))
ActionMailer::Base.default_url_options[:host] = ENV['domain']
