require 'rails_helper'

RSpec.describe Breakdown do
  describe "initialize" do
    it "has attributes" do
      breakdown_attributes = {
        id: "123",
        content: "This response will help break chores up into easy to complete steps"
      }
      breakdown = Breakdown.new(breakdown_attributes)

      expect(breakdown.id).to eq(breakdown_attributes[:id])
      expect(breakdown.content).to eq(breakdown_attributes[:content])
    end
  end
end
