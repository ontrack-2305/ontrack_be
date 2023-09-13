class WelcomeController < ApplicationController
  def index
    @response = AiResponseFacade.fetch_gpt_response("Build a catio")
  end
end