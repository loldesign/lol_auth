$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lol_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lol_auth"
  s.version     = LolAuth::VERSION
  s.authors     = ["Eduardo Zaghi"]
  s.email       = ["eduardo@loldesign.com.br"]
  s.homepage    = "http://loldesign.com.br"
  s.summary     = "Lol Auth"
  s.description = "Add auth features"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "omniauth", "~> 1.6"
  s.add_dependency "koala", "~> 2.2"
  s.add_dependency "devise_token_auth", "~> 1.1"
  s.add_dependency "paranoia", "~> 2.2"
  s.add_dependency "pg", ">= 0.18"
  s.add_dependency "jbuilder", '~> 2'
  s.add_dependency "carrierwave", '>= 1', '< 3'
  s.add_dependency "fog", '~> 1.38'
  s.add_dependency "mini_magick"

  s.add_development_dependency "pry-rails"
  s.add_development_dependency "mailcatcher"
end
