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
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "pg"
end
