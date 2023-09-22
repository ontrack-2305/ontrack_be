require "rails_helper"

RSpec.describe GoogleCalendarService do
  it "can connect to Google Calendar" do
    service = GoogleCalendarService.new(User.new(google_id: 1234, email: "example@test.com"))
    
    expect(service.connection).to be_a(Faraday::Connection)
  end
end