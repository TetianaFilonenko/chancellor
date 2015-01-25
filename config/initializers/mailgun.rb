if ENV['MAILGUN_SMTP_SERVER']
  ActionMailer::Base.smtp_settings = {
    :port => ENV.fetch('MAILGUN_SMTP_PORT'),
    :address => ENV.fetch('MAILGUN_SMTP_SERVER'),
    :user_name => ENV.fetch('MAILGUN_SMTP_LOGIN'),
    :password => ENV.fetch('MAILGUN_SMTP_PASSWORD'),
    :authentication => :plain
  }
  ActionMailer::Base.delivery_method = :smtp
end
