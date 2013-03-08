# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rench/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Micah Cooper"]
  gem.email         = ["mrmicahcooper@gmail.com"]
  gem.description   = %q{Keep all the files you use often in a Toolbox. Then easily grab them (or anyones) with Rench. }
  gem.summary       = "Have a toolbox of often used files. Use them and share them easily."
  gem.homepage      = "http://github.com/mrmicahcooper/rench"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ["rench"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rench"
  gem.require_paths = ["lib"]
  gem.version       = Rench::VERSION

  gem.add_dependency 'faraday'

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'

end
