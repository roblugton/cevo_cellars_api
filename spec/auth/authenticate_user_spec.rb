require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create test user
  let(:user) { create(:user) }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_auth_obj) { described_class.new('invalid', 'credentials') }

  # Test Suite for AuthenticatedUser#call
  describe '#call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
        .to raise_error(ExceptionHandler::AuthenticationError, /Invalid Credentials/)
      end
    end
  end
end