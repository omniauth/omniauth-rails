module OmniAuth
  module Rails
    module RequestForgeryProtection
      if ::Rails::VERSION::MAJOR == 3
        require "omniauth/rails/request_forgery_protection/rails_3_2"

        Current = Rails32
      elsif ::Rails::VERSION::MAJOR == 4 && ::Rails::VERSION::MINOR == 0
        require "omniauth/rails/request_forgery_protection/rails_4_0"

        Current = Rails40
      elsif ::Rails::VERSION::MAJOR == 4 && ::Rails::VERSION::MINOR == 1
        require "omniauth/rails/request_forgery_protection/rails_4_1"

        Current = Rails41
      else
        require "omniauth/rails/request_forgery_protection/rails_4_2"
        
        Current = Rails42
      end
    end
  end
end
