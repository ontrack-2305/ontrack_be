require "rails_helper"

RSpec.describe "Holiday Service API", :vcr do
  describe "Holiday service" do
    describe "happy path" do
      it "holiday service returns next three holidays" do
        get "/api/v1/holidays"
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to have_key(:data)
        expect(parsed_response[:data]).to be_an(Array)
        expect(parsed_response[:data].count).to eq(3)
        parsed_response[:data].each do |holiday|
          expect(holiday).to have_key(:type)
          expect(holiday[:type]).to eq("holiday")

          expect(holiday).to have_key(:attributes)
          expect(holiday[:attributes]).to be_a(Hash)


          expect(holiday[:attributes]).to have_key(:name)
          expect(holiday[:attributes][:name]).to be_a(String)

          expect(holiday[:attributes]).to have_key(:date)
          expect(holiday[:attributes][:date]).to be_a(String)
          expect(Date.today < holiday[:attributes][:date].to_date).to eq(true)
          expect(holiday[:attributes][:date]).to match(/\d{4}-\d{2}-\d{2}/)
        end
      end
    end
  end
end