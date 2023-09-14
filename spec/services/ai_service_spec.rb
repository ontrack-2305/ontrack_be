require 'rails_helper'

describe AiService do
  describe "instance methods" do
    describe "#fetch_gpt_response" do
      it "returns a response from openai's api", :vcr do
        ai_response = AiService.new.fetch_gpt_response("Do my laundry")
        expect(ai_response).to be_a Hash
        expect(ai_response[:choices]).to be_an Array
        expect(ai_response[:choices][0]).to be_a Hash
        expect(ai_response[:choices][0][:message]).to be_a Hash
        expect(ai_response[:choices][0][:message][:content]).to be_a String
      end
    end
  end
end