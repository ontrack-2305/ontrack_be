class ErrorMessage
  attr_reader :message, :status

  def initialize(message, status_code)
    @message = message
    @status = status_code
  end
end