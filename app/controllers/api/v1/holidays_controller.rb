class Api::V1::HolidaysController < ApplicationController

  def index
    holidays = HolidaysFacade.upcoming_holidays
    render json: HolidaysSerializer.new(holidays).as_json
  end
end