# frozen_string_literal: true
require 'rails'

module OmniAuth
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'OmniAuth request_forgery_protection' do
        OmniAuth.config.allowed_request_methods = [:post]
        OmniAuth.config.before_request_phase do |env|
          OmniAuth::Rails::RequestForgeryProtection.call(env)
        end
      end
    end
  end
end
