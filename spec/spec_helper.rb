# frozen_string_literal: true
$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'rspec'
require 'rack/test'
require 'omniauth'

require 'omniauth-rails/railtie'
require 'omniauth-rails/request_forgery_protection'
