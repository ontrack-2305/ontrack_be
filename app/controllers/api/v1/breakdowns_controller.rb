class Api::V1::BreakdownsController < ApplicationController

  def create
    @response = AiResponseFacade.fetch_gpt_response("#{query}")
  end
end