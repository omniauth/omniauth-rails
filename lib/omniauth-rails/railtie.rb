# frozen_string_literal: true
require 'rails'

module OmniAuth
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'OmniAuth request_forgery_protection' do
        OmniAuth.config.allowed_request_methods = [:post]

        method = OmniAuth.config.respond_to?(:validate_request_phase) ? 
          :validate_request_phase :
          :before_request_phase

        OmniAuth.config.send(method) do |env|
          OmniAuth::Rails::RequestForgeryProtection.call(env)
        end
      end
    end
  end
end
