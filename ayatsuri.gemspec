# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ayatsuri/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Hajime Sueyoshi"]
  gem.email         = ["h4zime@gmail.com"]
  gem.description   = %q{Ayatsuri is small framework for to automate a Windows application}
  gem.summary       = %q{Automation for Ruby}
  gem.homepage      = "https://github.com/h4zime/ayatsuri"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ayatsuri"
  gem.require_paths = ["lib"]
  gem.version       = Ayatsuri::VERSION
end
