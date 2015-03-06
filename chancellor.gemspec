$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'chancellor/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'chancellor'
  s.version     = Chancellor::VERSION
  s.authors     = ['Joseph Bridgwater-Rowe']
  s.email       = ['joe@westernmilling.com']
  s.homepage    = ''
  s.summary     = ''
  s.description = ''
  s.license     = 'Apache 2.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'devise'
  s.add_dependency 'interactor'#, :github => 'collectiveidea/interactor'
  s.add_dependency 'interactor-rails'
  s.add_dependency 'paranoia'
  s.add_dependency 'paper_trail'
  s.add_dependency 'puma'
  s.add_dependency 'pundit'
  s.add_dependency 'ransack'
  s.add_dependency 'rolify'
  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'sass-rails'
  s.add_dependency 'simple_form'
  s.add_dependency 'rolify'
  s.add_dependency 'squeel'
  s.add_dependency 'uglifier'
  s.add_dependency 'uuid'
  s.add_dependency 'virtus'

  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'coveralls'#, :require => false
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'shoulda-matchers'#, :require => false
end
