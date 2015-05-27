require 'omniauth/rails/request_forgery_protection'

module OmniAuth
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'logger' do
        OmniAuth.config.logger = ::Rails.logger
      end

      initializer 'request_forgery_protection' do
        OmniAuth.config.allowed_request_methods = [:post]
        OmniAuth.config.before_request_phase do |env|
          RequestForgeryProtection::Current.new(env).call
        end
      end
    end
  end
end
