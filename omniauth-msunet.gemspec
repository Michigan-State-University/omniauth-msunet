# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-msunet/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Troy Murray', 'Andrew Tomaka']
  gem.email         = ['tm@msu.edu', 'atomaka@msu.edu']
  gem.summary       = %q{Michigan State University MSUnet OmniAuth strategy.}
  gem.description   = %q{Official OmniAuth strategy for authenticating against the Michigan State University MSUnet OAuth2 provider.}
  gem.homepage      = "https://gitlab.msu.edu/msu-middleware-group/omniauth-msunet"
  gem.license       = 'MSU'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-msunet"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::MSUnet::VERSION

  gem.add_dependency 'omniauth', '~> 1.1'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_dependency 'multi_json', '~> 1.7'
  gem.add_development_dependency 'rspec', '~> 3.4'
end
