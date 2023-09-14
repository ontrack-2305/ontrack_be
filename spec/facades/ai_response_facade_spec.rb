require 'rails_helper'

describe AiResponseFacade do
  before do
    @ai_response = AiResponseFacade.fetch_gpt_response("Do my laundry")
  end

  describe "class methods" do
    it "returns a breakdown object", :vcr do
      expect(@ai_response).to be_a Breakdown
    end
  end
end