require "rails_helper"

RSpec.describe ErrorSerializer do
  it "formats error messages" do
    serializer = ErrorSerializer.new(ErrorMessage.new("Invalid", 200))

    expect(serializer.serialize_json).to eq(
      {
        errors: [
          {
            detail: "Invalid"
          }
        ]
      }
    )
  end
end