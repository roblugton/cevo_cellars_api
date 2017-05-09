require 'rails_helper'

RSpec.describe AuthorizeApiRequest do

  # Create a test user
  let(:user) { create(:user) }

  # Test Suite for AuthorizeApiRequest#call
  # This is our entry point into the service class
  describe '#call' do

    # returns user object when request is valid
    context 'when valid request' do

      it 'returns a user object' do
        # returns user object when request is valid
        it 'returns user object' do
          result = valid_request.call
          expect(result[:user]).to eq(user)
        end
      end
    end
  end
end
