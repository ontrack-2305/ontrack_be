require 'rails_helper'

RSpec.describe HolidaysSerializer do
  describe '#as_json' do

    it 'returns the correct JSON structure', :vcr do
      holidays = HolidaysFacade.upcoming_holidays
      result = HolidaysSerializer.new(holidays).as_json

      result[:data].each do |holiday|
        expect(holiday).to have_key(:type)
        expect(holiday[:type]).to eq("holiday")

        expect(holiday).to have_key(:attributes)
        expect(holiday[:attributes]).to be_a(Hash)


        expect(holiday[:attributes]).to have_key(:name)
        expect(holiday[:attributes][:name]).to be_a(String)

        expect(holiday[:attributes]).to have_key(:date)
        expect(holiday[:attributes][:date]).to be_a(String)
        expect(Date.today < holiday[:attributes][:date].to_date).to eq(true)
        expect(holiday[:attributes][:date]).to match(/\d{4}-\d{2}-\d{2}/)
      end
    end
  end
end
