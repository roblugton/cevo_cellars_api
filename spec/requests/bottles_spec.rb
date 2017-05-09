require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:cellar) { create(:cellar) }
  let!(:bottles) { create_list(:bottle, 20, cellar_id: cellar.id)}
  let(:cellar_id) { cellar.id }
  let(:id) { bottles.first.id }

  # Test Suite for GET /cellars/:cellar_id/bottles
  describe 'GET /cellars/:cellar_id/bottles' do
    before { get "/cellars/#{cellar_id}/bottles" }

    context 'when cellar exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all bottle in the cellar' do
        expect(json.size).to eq(20)
      end
    end

    context 'when cellar does not exist' do
      let(:cellar_id) { 0 }

      it 'returns a status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cellar/)
      end
    end
  end

  # Test Suite for GET /cellars/:cellar_id/bottles/:id
  describe 'GET /cellars/:cellar_id/bottles/:id' do
    before { get "/cellars/#{cellar_id}/bottles/#{id}" }

    context 'when cellar bottle exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the bottle' do
        expect(json['id']).to eq(id)
      end
    end
  end

end