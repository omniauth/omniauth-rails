module OmniAuth
  module Rails
    module RequestForgeryProtection
      class Base
        def initialize(env)
          @env = env
        end

        def request
          @_request ||= ActionDispatch::Request.new(@env)
        end

        def session
          request.session
        end

        def reset_session
          request.reset_session
        end

        def params
          @_params ||= request.parameters
        end

        def call
          verify_authenticity_token
        end

        def verify_authenticity_token
          return if verified_request?

          if OmniAuth.logger && log_warning_on_csrf_failure
            OmniAuth.logger.warn "Can't verify CSRF token authenticity" 
          end
          
          handle_unverified_request
        end

        private

        def handle_unverified_request
          # Implemented by subclass.
        end

        def verified_request?
          !protect_against_forgery? || request.get? || request.head? ||
            valid_authenticity_token?(session, form_authenticity_param) ||
            valid_authenticity_token?(session, request.headers['X-CSRF-Token'])
        end

        def valid_authenticity_token?
          # Implemented by subclass.
        end

        def protect_against_forgery?
          ::ApplicationController.allow_forgery_protection
        end

        def request_forgery_protection_token
          ::ApplicationController.request_forgery_protection_token
        end

        def log_warning_on_csrf_failure
          true
        end

        def form_authenticity_param
          params[request_forgery_protection_token]
        end
      end
    end
  end
end
