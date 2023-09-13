
class WelcomeController < ApplicationController
  def index
    @response = AiResponseFacade.fetch_gpt_response("Build a catio")
    @holidays = HolidaysFacade.upcoming_holidays
  end
end

