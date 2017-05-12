require 'rails_helper'

RSpec.describe 'Users API', type: :request do

  # test suite for POST /signup
  describe 'POST /signup' do
    let!(:user) {build(:user)}
    let(:headers) {valid_headers.except('Authorization')}
    let(:valid_attributes) do
      attributes_for(:user, password_confirmation: user.password)
    end

    # when the request is valid
    context 'when the request is valid' do
      before { post '/signup', params: valid_attributes }
      context 'when the user does not exist' do
        it 'creates a new user' do
          expect(response).to have_http_status(201)
        end
        it 'returns a success message' do
          expect(json['message']).to match(/Account created successfully/)
        end
        it 'returns an authentication token' do
          expect(json['auth_token']).not_to be_nil
        end
        it 'returns a valid authentication token' do
          expect(json['auth_token']).to match(/[A-Za-z0-9]*\.[A-Za-z0-9]*\.[A-Za-z0-9]*/)
        end
      end

      context 'when the user already exists' do
        before { post '/signup', params: valid_attributes }

        it 'returns an already exists status' do
          expect(response).to have_http_status(422)
        end

        it 'returns an already exists message' do
          expect(json['message']).to match(/Account already exists/)
        end
      end
    end

    context 'when the request is invalid' do
      before {post '/signup', params: {}, headers: headers}
      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end
      it 'returns a failure message' do
        expect(json['message'])
            .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end
