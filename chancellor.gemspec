$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chancellor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chancellor"
  s.version     = Chancellor::VERSION
  s.authors     = ["Joseph Bridgwater-Rowe"]
  s.email       = ["joe@westernmilling.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Chancellor."
  s.description = "TODO: Description of Chancellor."
  s.license     = "Apache 2.0"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'paranoia'
  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'rspec-its'
  s.add_dependency 'rspec-rails'
  s.add_dependency 'shoulda-matchers'
  s.add_dependency 'uuid'

  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'pg'
end
