require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication Test Suite
  describe 'POST /auth/login' do
    # create test user
    let(:user) { create(:user) }
    # valid subject request
    subject(:headers) { valid_headers.except('Authorization') }
    # valid credentials
    let(:valid_creds) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    # invalid credentials
    let(:invalid_creds) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # set request headers to custom headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    context 'When request is valid' do
      before { post '/auth/login', params: valid_creds, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end

      # check that the token returnend matches soemthing that looks like a JWT token
      it 'returns a valid authentication token' do
        expect(json['auth_token']).to match(/[A-Za-z0-9]*\.[A-Za-z0-9]*\.[A-Za-z0-9]*/)
      end
    end

    context 'When a request is invalid' do
      before { post '/auth/login', params: invalid_creds, headers: headers }
      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid Credentials/)
      end
    end
  end
end