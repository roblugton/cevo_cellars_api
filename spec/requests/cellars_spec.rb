require 'rails_helper'

RSpec.describe 'Cellars API', type: :request do
    # initialise test data
    let!(:cellars) { create_list(:cellar, 10) }
    let(:cellar_id) { cellars.first.id }

    # Test suite for GET /cellars
    describe 'GET /cellars' do
        
        # make HTTP get requests before each example
        before { get '/cellars'}

        it 'returns cellars' do
            expect(json).not_to be_empty
            expect(json.size).to equal(10)
        end
        
        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # test suite for GET /cellars/:id
    describe 'GET /cellars/:id' do
        before { get "/cellars/#{cellar_id}" }

        context 'when the record exists' do
           
           it 'returns the cellar' do
               expect(json).not_to be_empty
               expect(json['id']).to equal(cellar_id)
           end 

           it 'returns the status code 200' do
               expect(response).to have_http_status(200)
           end
        end

        context 'when the record does not exist' do
            let(:cellar_id) { 101 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Cellar/)
            end
        end
    end
end
