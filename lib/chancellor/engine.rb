module Chancellor
  class Engine < ::Rails::Engine
    isolate_namespace Chancellor

    config.generators do |g|
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.stylesheets false
      g.javascripts false
      g.test_framework :rspec, :fixture => false
      g.view_specs false
      g.helper_specs false
    end
  end
end
