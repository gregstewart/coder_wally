# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coder_wally/version'

Gem::Specification.new do |spec|
  spec.name          = 'coder_wally'
  spec.version       = CoderWally::VERSION
  spec.authors       = ['Greg Stewart']
  spec.email         = ['gregs@tcias.co.uk']
  spec.summary       = %q{A simple gem to fetch user badges from Coder Wall}
  spec.description   = %q{A simple gem to fetch user badges from Coder Wall}
  spec.homepage      = 'https://github.com/gregstewart/coder_wally'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.0'

  spec.add_development_dependency 'rake', '~> 11.1.1'
  spec.add_development_dependency 'webmock', '~>1.24.2'
  spec.add_development_dependency 'coveralls', '~>0.8.13'
  spec.add_development_dependency 'minitest', ' ~>5.8.4'
end
