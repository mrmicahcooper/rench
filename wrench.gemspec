# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wrench/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Micah Cooper"]
  gem.email         = ["mrmicahcooper@gmail.com"]
  gem.description   = %q{Keep all the files you use often in a Toolbox. Then easily grab them (or anyones) with Wrench. }
  gem.summary       = ""
  gem.homepage      = "http://github.com/mrmicahcooper/github_wrench"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wrench"
  gem.require_paths = ["lib"]
  gem.version       = Wrench::VERSION

  gem.add_dependency 'faraday'

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
end
