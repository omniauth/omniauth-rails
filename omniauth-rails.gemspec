# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth-rails/version"

Gem::Specification.new do |spec|
  spec.name          = "omniauth-rails"
  spec.version       = OmniAuthRails::VERSION
  spec.authors       = ["Erik Michaels-Ober", "Douwe Maan"]
  spec.email         = ["sferik@gmail.com", "douwe@gitlab.com"]

  spec.description   = "Ruby on Rails extensions to OmniAuth"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/omniauth/omniauth-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth"
  spec.add_dependency "rails"
  spec.add_development_dependency "bundler", "~> 1.9"
end
