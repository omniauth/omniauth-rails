require 'omniauth/rails/request_forgery_protection/base'

module OmniAuth
  module Rails
    module RequestForgeryProtection
      # Based on ActionController::RequestForgeryProtection in Rails 4.1.10.
      class Rails41 < Base

        private

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
