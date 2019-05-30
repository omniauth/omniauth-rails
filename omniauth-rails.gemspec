# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'omniauth-rails/version'

Gem::Specification.new do |gem|
  gem.authors       = ['Tom Milewski']
  gem.email         = ['tmilewski@gmail.com']
  gem.description   = 'Official Rails OmniAuth gem.'
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/omniauth/omniauth-rails'
  gem.license       = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'omniauth-rails'
  gem.require_paths = %w[lib]
  gem.version       = OmniAuth::Rails::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'rails'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'simplecov'
end
