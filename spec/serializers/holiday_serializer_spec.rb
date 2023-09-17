require 'rails_helper'

RSpec.describe HolidaysSerializer do
  describe '#as_json' do

    it 'returns the correct JSON structure', :vcr do
      holidays = HolidaysFacade.upcoming_holidays
      result = HolidaysSerializer.new(holidays).as_json
      expect(result).to eq({:data=>
      [{:type=>"holiday", :attributes=>{:name=>"Columbus Day", :date=>"2023-10-09"}},
       {:type=>"holiday", :attributes=>{:name=>"Veterans Day", :date=>"2023-11-10"}},
       {:type=>"holiday", :attributes=>{:name=>"Thanksgiving Day", :date=>"2023-11-23"}}]})
    end
  end
end
