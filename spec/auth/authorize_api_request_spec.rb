require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  # Create a test user
  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  subject(:valid_request_obj) { described_class.new(header) }
  subject(:invalid_request_obj) { described_class.new({}) }
  # Test Suite for AuthorizeApiRequest#call
  # This is our entry point into the service class
  describe '#call' do

    # returns user object when request is valid
    context 'when valid request' do
      it 'returns a user object' do
        result = valid_request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    #returns error message when request is invalid
    context 'when request is invalid' do
      context 'when token is missing' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end
      context 'when token is invalid' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end
        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end
      context 'when the token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:valid_request_obj) { described_class.new(header) }

        it 'raises an ExceptionHandler::ExpiredSignature error' do
          expect { valid_request_obj.call }
            .to raise_error(ExceptionHandler::ExpiredSignature, /Signature has expired/)
        end
      end
    end
  end
end
