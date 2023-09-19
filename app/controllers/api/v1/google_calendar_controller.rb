class Api::V1::GoogleCalendarController < ApplicationController

  def index
    user = User.new(params)
    calendar_events = CalendarEventsFacade.upcoming_events(user)
  
    require 'pry'; binding.pry
    render json: CalendarEventsSerializer.new(calendar_events).as_json
  end
end