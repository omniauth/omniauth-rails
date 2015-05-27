require 'omniauth/rails/request_forgery_protection/rails_4_1'

require 'action_controller'
require 'active_support/security_utils'

module OmniAuth
  module Rails
    module RequestForgeryProtection
      # Based on ActionController::RequestForgeryProtection in Rails 4.2.1.
      class Rails42 < Rails41

        private

        def log_warning_on_csrf_failure
          ::ApplicationController.log_warning_on_csrf_failure
        end

        AUTHENTICITY_TOKEN_LENGTH = ActionController::RequestForgeryProtection::AUTHENTICITY_TOKEN_LENGTH

        # Sets the token value for the current session.
        def form_authenticity_token
          masked_authenticity_token(session)
        end

        # Creates a masked version of the authenticity token that varies
        # on each request. The masking is used to mitigate SSL attacks
        # like BREACH.
        def masked_authenticity_token(session)
          one_time_pad = SecureRandom.random_bytes(AUTHENTICITY_TOKEN_LENGTH)
          encrypted_csrf_token = xor_byte_strings(one_time_pad, real_csrf_token(session))
          masked_token = one_time_pad + encrypted_csrf_token
          Base64.strict_encode64(masked_token)
        end

        # Checks the client's masked token to see if it matches the
        # session token. Essentially the inverse of
        # +masked_authenticity_token+.
        def valid_authenticity_token?(session, encoded_masked_token)
          if encoded_masked_token.nil? || encoded_masked_token.empty? || !encoded_masked_token.is_a?(String)
            return false
          end

          begin
            masked_token = Base64.strict_decode64(encoded_masked_token)
          rescue ArgumentError # encoded_masked_token is invalid Base64
            return false
          end

          # See if it's actually a masked token or not. In order to
          # deploy this code, we should be able to handle any unmasked
          # tokens that we've issued without error.

          if masked_token.length == AUTHENTICITY_TOKEN_LENGTH
            # This is actually an unmasked token. This is expected if
            # you have just upgraded to masked tokens, but should stop
            # happening shortly after installing this gem
            compare_with_real_token masked_token, session

          elsif masked_token.length == AUTHENTICITY_TOKEN_LENGTH * 2
            # Split the token into the one-time pad and the encrypted
            # value and decrypt it
            one_time_pad = masked_token[0...AUTHENTICITY_TOKEN_LENGTH]
            encrypted_csrf_token = masked_token[AUTHENTICITY_TOKEN_LENGTH..-1]
            csrf_token = xor_byte_strings(one_time_pad, encrypted_csrf_token)

            compare_with_real_token csrf_token, session

          else
            false # Token is malformed
          end
        end

        def compare_with_real_token(token, session)
          ActiveSupport::SecurityUtils.secure_compare(token, real_csrf_token(session))
        end

        def real_csrf_token(session)
          session[:_csrf_token] ||= SecureRandom.base64(AUTHENTICITY_TOKEN_LENGTH)
          Base64.strict_decode64(session[:_csrf_token])
        end

        def xor_byte_strings(s1, s2)
          s1.bytes.zip(s2.bytes).map { |(c1,c2)| c1 ^ c2 }.pack('c*')
        end
      end
    end
  end
end
