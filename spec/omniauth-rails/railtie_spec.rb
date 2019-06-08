# frozen_string_literal: true
require 'spec_helper'

describe OmniAuth::Rails::Railtie do
  describe 'Railtie' do
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

  describe 'Railtie Integration' do
    let(:app) { Rails.application }

    let(:authenticity_token) do
      get "/token"
      last_response.body
    end

    it 'should disallow access to :get with 404' do
      get '/auth/developer'
      expect(last_response.status).to eq(404)
    end

    it 'should fail as 422 without a token' do
      post '/auth/developer'
      expect(last_response.status).to eq(422)
    end

    it 'should fail with a bad token' do
      post '/auth/developer', authenticity_token: 'foo'
      expect(last_response.status).to eq(422)
    end

    it 'should succeed with a vaild token' do
      post '/auth/developer', authenticity_token: authenticity_token
      expect(last_response.status).to eq(200)
    end
  end
end
