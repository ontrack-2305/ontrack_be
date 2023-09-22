require "rails_helper"

RSpec.describe CalendarEvent do
  it "exists" do
    event = CalendarEvent.new({
      "summary" => "A summary",
      "start" => {
        "dateTime" => "2012-07-12T10:30:00.0z"
      },
      "description" => "A description"
      })

    expect(event).to be_a(CalendarEvent)
    expect(event.name).to eq("A summary")
    expect(event.start_date).to eq("2012-07-12T10:30:00.0z")
    expect(event.description).to eq("A description")
  end

  it "can format date" do
    event = CalendarEvent.new({
      "summary" => "A summary",
      "start" => {
        "dateTime" => "2012-07-12T10:30:00.0z"
      },
      "description" => "A description"
      })

    expect(event.formatted_start_date).to be_a(String)
    expect(event.formatted_start_date).to eq("07/12/2012 10:30:00")
  end
end