class Api::V1::BreakdownsController < ApplicationController

  def show
    response = AiResponseFacade.fetch_gpt_response("#{params[:task]}")
    render json: BreakdownSerializer.new(response.content).as_json
  end
end