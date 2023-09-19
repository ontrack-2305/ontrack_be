class Api::V1::UsersController < ApplicationController

  def authenticate
    user = User.new(params)
    calendar_events = CalendarEventsFacade.upcoming_events(user)

  end
end