require 'omniauth/rails/request_forgery_protection/base'

module OmniAuth
  module Rails
    module RequestForgeryProtection
      # Based on ActionController::RequestForgeryProtection in Rails 3.2.21.
      class Rails32 < Base

        private

        # This is the method that defines the application behavior when a request is found to be unverified.
        # By default, \Rails resets the session when it finds an unverified request.
        def handle_unverified_request
          reset_session
        end

        def valid_authenticity_token?(session, param)
          form_authenticity_token == param
        end

        # Sets the token value for the current session.
        def form_authenticity_token
          session[:_csrf_token] ||= SecureRandom.base64(32)
        end
      end
    end
  end
end
