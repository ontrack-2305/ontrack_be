class CalendarEventsFacade
  def self.upcoming_events(user)
    upcoming_events = []
    service = GoogleCalendarService.new(user)
    raw_events = service.fetch_events
    raw_events["items"].each do |event_data|
      event = CalendarEvent.new(event_data)
      start_date = DateTime.parse(event.start_date) if event.start_date
      if start_date != nil && start_date > DateTime.now && start_date < (DateTime.now + 14.days)
        upcoming_events << event
      end
    end
    upcoming_events
    require 'pry'; binding.pry
  end
end