require 'omniauth/rails/request_forgery_protection/rails_3_2'

module OmniAuth
  module Rails
    module RequestForgeryProtection
      # Based on ActionController::RequestForgeryProtection in Rails 4.0.13.
      class Rails40 < Rails32

        private

        def forgery_protection_strategy
          ::ApplicationController.forgery_protection_strategy
        end

        def handle_unverified_request
          forgery_protection_strategy.new(self).handle_unverified_request
        end
      end
    end
  end
end
