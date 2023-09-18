class Api::V1::GoogleCalendarController < ApplicationController

  def index
    require 'pry'; binding.pry
    render json: HolidaysSerializer.new(events).as_json
  end
end