require 'rails_helper'

describe 'Events API', type: :request do

    describe 'GET /events' do
        it 'should return all events' do

            FactoryBot.create(:event, name: 'test button', event_type: 'click')
            FactoryBot.create(:event, name: 'test image', event_type: 'view')

            get '/api/v1/events'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'GET /events/today' do
        it 'should return summary of events for today' do

            FactoryBot.create(:event, name: 'test button', event_type: 'click')
            FactoryBot.create(:event, name: 'test image', event_type: 'view')

            get '/api/v1/events/today'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body)["EG"]["todays_stats"][0]["click"]).to eq(1)
            expect(JSON.parse(response.body)["EG"]["todays_stats"][1]["view"]).to eq(1)
        end
    end

    describe 'POST /events' do
        it 'should create a new event' do
            expect {
                post '/api/v1/events', params: { event: { name: "test button", event_type: "click", at: "2020-06-12T00:00:01", button_color: "red" } }
            }.to change { Event.count }.from(0).to(1)
            
            expect(response).to have_http_status(:created)
        end

        it 'should not create a new event without a NAME key' do
            post '/api/v1/events', params: { event: { names: "test button", event_type: "click", at: "2020-06-12T00:00:01", button_color: "red" } }
            
            expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should not create a new event without a EVENT_TYPE key' do
            post '/api/v1/events', params: { event: { name: "test button", event_types: "click", at: "2020-06-12T00:00:01", button_color: "red" } }
            
            expect(response).to have_http_status(:unprocessable_entity)
        end
    end
end