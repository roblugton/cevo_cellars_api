require 'rails_helper'

RSpec.describe 'Cellars API', type: :request do
  # initialise test data
  let(:user) { create(:user) }
  let!(:cellars) { create_list(:cellar, 10) }
  let(:cellar_id) { cellars.first.id }
  let(:headers) { valid_headers }
  # Test suite for GET /cellars
  describe 'GET /cellars' do

    # make HTTP get requests before each example
    before { get '/cellars', params: {}, headers: headers }

    it 'returns cellars' do
      puts "JSON: #{json}"
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # test suite for GET /cellars/:id
  describe 'GET /cellars/:id' do
    before { get "/cellars/#{cellar_id}", params: {}, headers: headers }

    context 'when the record exists' do

      it 'returns the cellar' do

        expect(json).not_to be_empty
        expect(json['id']).to eq(cellar_id)
      end

      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:cellar_id) {101}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cellar/)
      end
    end
  end

  # test suite for POST /cellars
  describe 'POST /cellars' do
    let(:valid_attributes) { { name: "Cevo Cellar" }.to_json }

    context 'when the request is valid' do
      before { post '/cellars', params: valid_attributes, headers: headers }

      it "creates a cellar" do
        expect(json['name']).to eq('Cevo Cellar')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { name: nil }.to_json }
      before { post '/cellars', params: valid_attributes, headers: headers }

      it "returns a status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # test suite for PUT /cellars/:id
  describe 'PUT /cellars/:id' do
    let(:valid_attributes) { { Name: "Cevo Cellar"}.to_json }

    context 'when the record is valid' do
      before { put "/cellars/#{cellar_id}", params: valid_attributes, headers: headers }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

    end
  end

  # test suite for DELETE /cellars/:id
  describe 'Delete /cellar/:id' do
    before { delete "/cellars/#{cellar_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
