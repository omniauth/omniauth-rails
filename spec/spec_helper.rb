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

class TestApp < Rails::Application
  config.root = __dir__
  config.session_store :cookie_store, key: 'cookie_store_key'
  secrets.secret_key_base = 'secret_key_base'
  config.eager_load = false
  config.hosts = []

  # This allow us to send all logs to STDOUT if we run test wth `VERBOSE=1`
  config.logger = if ENV['VERBOSE']
                    Logger.new($stdout)
                  else
                    Logger.new('/dev/null')
                  end
  Rails.logger = config.logger
  OmniAuth.config.logger = Rails.logger

  # Setup a simple OmniAuth configuration with only developer provider
  config.middleware.use OmniAuth::Builder do
    provider :developer
  end

  # We need to call initialize! to run all railties
  initialize!

  # Define our custom routes. This needs to be called after initialize!
  routes.draw do
    get "token" => "application#token"
  end
end

# A small test controller which we use to retrive the valid authenticity token
class ApplicationController < ActionController::Base
  def token
    render plain: form_authenticity_token
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
