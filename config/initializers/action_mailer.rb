smtp = YAML.load_file(File.join(Rails.root, 'config/smtp.yml'))

ActionMailer::Base.default_url_options = {
  :host => smtp[:host]
}
