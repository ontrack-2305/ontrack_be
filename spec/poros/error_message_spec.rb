require "rails_helper"

RSpec.describe ErrorMessage do
  it "exists" do
    message = ErrorMessage.new("Invalid", 400)
    expect(message.message).to eq("Invalid")
    expect(message.status).to eq(400)
  end
end