require 'rails_helper'

RSpec.describe Holiday do
  it "exists and has attributes" do
    data = {
      "date": "2023-10-09",
      "name": "Columbus Day"
    }

    holiday = Holiday.new(data)

    expect(holiday).to be_a Holiday
    expect(holiday.date).to eq("2023-10-09")
    expect(holiday.name).to eq("Columbus Day")
  end
end