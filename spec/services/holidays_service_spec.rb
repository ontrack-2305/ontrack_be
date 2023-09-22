require 'rails_helper'

RSpec.describe HolidaysService, :vcr do
  it "connects to the api and returns upcoming holidays" do
    search = HolidaysService.new.upcoming_holidays

    expect(search).to be_an Array
    expect(search.count).to eq(12)

    search.each do |holiday|
      expect(holiday).to have_key :date
      expect(holiday[:date]).to be_a String

      expect(holiday).to have_key :name
      expect(holiday[:name]).to be_a String
    end
  end
end