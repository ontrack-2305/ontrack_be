class BreakdownSerializer
  def initialize(message)
    @message = message
  end

  def clean_message
    @message = @message.gsub("\n", " ")
  end

  def as_json
    clean_message
    {
      "response": [{
                    "text": "#{@message}"
                  }]
    }
  end
end