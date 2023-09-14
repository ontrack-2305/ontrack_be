class BreakdownSerializer
  def initialize(message)
    @message = message
  end

  def as_json
    {
      "response": [{
                    "text": "#{@message}"
                  }]
    }
  end
end