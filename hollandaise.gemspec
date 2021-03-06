# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hollandaise/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Get delicious screenshots from Sauce Labs, easily}
  gem.summary       = %q{Get delicious screenshots from Sauce Labs, easily}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "hollandaise"
  gem.require_paths = ["lib"]
  gem.version       = Hollandaise::VERSION

  gem.add_dependency 'sauce'
  gem.add_dependency 'capybara'
  gem.add_dependency 'thor'
  gem.add_dependency 'arbre'
  gem.add_dependency 'rainbow'
  gem.add_dependency 'rack-proxy'
end

