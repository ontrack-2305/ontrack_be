class WelcomeController < ApplicationController
  def index
    response = AiResponseFacade.fetch_gpt_response("Build a catio")
    render json: BreakdownSerializer.new(response.content).as_json
  end
end
