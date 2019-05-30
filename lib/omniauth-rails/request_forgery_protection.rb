# frozen_string_literal: true
require 'action_controller'

module OmniAuth
  module Rails
    module RequestForgeryProtection
      class Controller < ActionController::Base
        protect_from_forgery :with => :exception, :prepend => true

        rescue_from ActionController::InvalidAuthenticityToken do |e|
          # Log warning
          raise e
        end

        def index
          head :ok
        end
      end

      def self.app
        @app ||= Controller.action(:index)
      end

      def self.call(env)
        app.call(env)
      end

      def self.verified?(env)
        call(env)

        true
      rescue ActionController::InvalidAuthenticityToken
        false
      end
    end
  end
end
