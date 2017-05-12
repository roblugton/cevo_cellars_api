require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user) }
  # Test suite for authorize_request
  describe '#authorize_request' do
    context 'when the auth token is passed in' do
      before { allow(request).to receive(:headers).and_return(valid_headers) }
      it 'sets the current user' do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end
    context 'when the auth token is missing' do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end
      it 'raises a MissingToken error' do
        expect { subject.instance_eval { authorize_request } }
      end
    end
  end
end
