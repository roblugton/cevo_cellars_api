require 'rails_helper'

RSpec.describe 'Bottles API', type: :request do
  let(:user) { create(:user) }
  let!(:cellar) { create(:cellar) }
  let!(:bottles) { create_list(:bottle, 20, cellar_id: cellar.id) }
  let(:cellar_id) { cellar.id }
  let(:id) { bottles.first.id }
  let(:headers) { valid_headers }

  # Test Suite for GET /cellars/:cellar_id/bottles
  describe 'GET /cellars/:cellar_id/bottles' do
    before { get "/cellars/#{cellar_id}/bottles", params: {}, headers: headers }

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
    before { get "/cellars/#{cellar_id}/bottles/#{id}", params: {}, headers: headers }

    context 'when cellar bottle exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the bottle' do
        expect(json['id']).to eq(id)
      end
    end
  end

  # Test Suite for POST /cellars/:cellar_id/bottles
  describe 'POST /cellars/:cellar_id/bottles' do
    let(:valid_params) {
      {
        name: 'Funky Wine',
        varietal: 'Orange',
        winery: 'Funky Winery',
        vintage: 1980,
        description: 'A funky wine from Funky Winery'
      }.to_json
    }

    context 'when request attributes are valid' do
      before { post "/cellars/#{cellar_id}/bottles", params: valid_params, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

    end

    context 'when request attributes are invalid' do
      before { post "/cellars/#{cellar_id}/bottles", params: {}, headers: headers }

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end

  end

  # Test Suite for PUT /cellars/:cellar_id/bottles/:id
  describe 'PUT /cellar/:cellar_id/bottles/:id' do
    let(:updated_name) { "Super Serious Wine" }
    let(:valid_params) { { name: updated_name }.to_json }
    before { put "/cellars/#{cellar_id}/bottles/#{id}", params: valid_params, headers: headers }

    context 'when bottle exists' do

      it 'returns a status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_bottle = Bottle.find(id)
        expect(updated_bottle.name).to match(/#{updated_name}/)
      end
    end

    context 'when bottle does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bottle/)
      end
    end
  end

  # Test Suite for DELETE /cellars/:cellar_id/bottles/:id
  describe 'DELETE /cellar/:cellar_id/bottles/:id' do
    context 'bottle exists' do
      before { delete "/cellars/#{cellar_id}/bottles/#{id}", params: {}, headers: headers }
      it 'returns http status code 204' do
        expect(response).to have_http_status(204)
      end
    end
    context 'bottle does not exist' do
      before { delete "/cellars/#{cellar_id}/bottles/0", params: {}, headers: headers }

      it 'returns http status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end