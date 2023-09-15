class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def not_found_response(error)
    render json: ErrorSerializer.new(ErrorMessage.new(error.message, 404)).serialize_json, status: 404
  end

  def invalid_response(error)
    render json: ErrorSerializer.new(ErrorMessage.new(error.message, 400)).serialize_json, status: 400
  end
end