# frozen_string_literal: true
require 'spec_helper'

describe OmniAuth::Rails::Railtie do
  before do
    OmniAuth::Rails::Railtie.initializers.each(&:run)
  end

  it 'should only allow POST requests' do
    expect(OmniAuth.config.allowed_request_methods).to eq([:post])
  end

  it '`before_request_phase` should call `OmniAuth::Rails::RequestForgeryProtection`' do
    env = {}
    expect(OmniAuth::Rails::RequestForgeryProtection).to receive(:call).with(env)
    OmniAuth.config.before_request_phase.call(env)
  end
end
