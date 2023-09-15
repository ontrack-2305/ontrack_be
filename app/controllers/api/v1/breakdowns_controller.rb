class Api::V1::BreakdownsController < ApplicationController

  def show
    if params[:task] == "" || !params[:task] 
      error = ErrorMessage.new("No task provided to breakdown", 400)
      render json: ErrorSerializer.new(ErrorMessage.new(error.message, 400)).serialize_json, status: 400
    else
      response = AiResponseFacade.fetch_gpt_response("#{params[:task]}")
      render json: BreakdownSerializer.new(response.content).as_json
    end
  end
end