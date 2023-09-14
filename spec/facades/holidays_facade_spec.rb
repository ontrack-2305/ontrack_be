require 'rails_helper'

RSpec.describe HolidaysFacade, :vcr do
  it "returns upcoming holidays" do
    holidays = HolidaysFacade.upcoming_holidays

    expect(holidays.first).to be_a(Holiday)
    expect(holidays.first.name).to be_a(String)
    expect(holidays.first.date).to be_a(String)
  end
end