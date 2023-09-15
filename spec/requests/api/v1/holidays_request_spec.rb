require "rails_helper"

RSpec.describe "Holiday Service API", :vcr do
  describe "Holiday service" do
    describe "happy path" do
      it "holiday service returns next three holidays" do
        get "/api/v1/holidays"
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"data"=>
        [{"type"=>"holiday", "attributes"=>{"name"=>"Columbus Day", "date"=>"2023-10-09"}},
         {"type"=>"holiday", "attributes"=>{"name"=>"Veterans Day", "date"=>"2023-11-10"}},
         {"type"=>"holiday", "attributes"=>{"name"=>"Thanksgiving Day", "date"=>"2023-11-23"}}]})
      end
    end
  end
end