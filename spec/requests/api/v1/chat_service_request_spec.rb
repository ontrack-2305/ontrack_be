require "rails_helper"

RSpec.describe "Chat Service API", :vcr do
  describe "Chat service" do
    describe "happy path" do
      it "chat service task breakdown" do
        get "/api/v1/chat_service", params: { task: "Do my laundry" }
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["response"][0]["text"]).to be_a(String)
      end
    end

    describe "sad path" do
      it "returns error message if task param is empty" do
        get "/api/v1/chat_service", params: { task: "" }
        expect(response.status).to eq(400)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"errors"=>[{"detail"=>"No task provided to breakdown"}]})
      end

      it "returns error message if there is no task param" do
        get "/api/v1/chat_service"
        expect(response.status).to eq(400)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq("errors" => [{"detail"=>"No task provided to breakdown"}])
      end
    end
  end
end