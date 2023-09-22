require "rails_helper"

RSpec.describe CalendarEventsSerializer do
  it "formats events" do
    event = CalendarEvent.new({
      "summary" => "A summary",
      "start" => {
        "dateTime" => "2012-07-12T10:30:00.0z"
      },
      "description" => "A description"
      })

    serializer = CalendarEventsSerializer.new([event])

    expect(serializer.as_json).to eq(
      {
        'data': 
          [
            {
              'type': 'Calendar Event',
                'attributes': {
                  'name': "A summary",
                  'start_date': "07/12/2012 10:30:00",
                  'description': "A description"
              }
            } 
          ]
      }
    )
  end
end