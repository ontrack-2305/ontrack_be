class CalendarEventsSerializer
  def initialize(events)
    @events = events
  end
  
  def as_json
    {
      'data': @events.map do |event|
                {
                  'type': 'Calendar Event',
                  'attributes': {
                    'name': event.name,
                    'start_date': event.formatted_start_date,
                    'description': event.description
                  }
                }
              end
    }
  end
end