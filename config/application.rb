require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Entities
  # Rails application
  class Application < Rails::Application
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.i18n.load_path += Dir[Rails.root.join(
      'my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    config.assets.paths << Rails.root.join(
      'vendor', 'assets', 'bower_components')

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.test_framework :rspec, :fixture => false
      g.view_specs false
      g.helper_specs false
    end
  end
end
