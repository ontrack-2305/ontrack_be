require "rails_helper"

RSpec.describe "Chat Service API", :vcr do
  describe "Chat service" do
    describe "chat service task breakdown" do
      it "happy path" do
        get "/api/v1/chat_service", params: { task: "Do my laundry" }
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["response"][0]["text"]).to eq("1. Sort laundry into different piles (whites, darks, colors). 2. Check care labels on each item to determine proper washing instructions. 3. Load the washing machine with one pile of laundry at a time. 4. Add detergent and set the appropriate wash cycle. 5. Transfer the cleaned laundry to the dryer or hang them to air dry.")
      end
    end
  end
end