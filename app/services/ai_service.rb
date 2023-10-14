class AiService
  def get_url(url, payload = nil)
    response = conn.post(url, payload)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.openai.com',
                headers: {
                  'Authorization' => "Bearer #{Rails.application.credentials.openai[:api_key]}",
                  'Content-Type' => 'application/json'
                })
  end

  def fetch_gpt_response(query)
    payload = {
      model: "gpt-3.5-turbo", 
      max_tokens: 100,
      messages: [
        {
          role: "system",
          content: "You are a helpful assistant."
        },
        {
          role: "user",
          content: "Please break down the following task into easier to complete components: #{query}. 
                    Ensure you complete the task breakdown in 100 tokens or less. 
                    Don't display the amount of tokens used.
                    Try to complete each task breakdown in five steps or less.
                    Be brief, but comprehensive."
        }
      ]
    }.to_json

    get_url('/v1/chat/completions', payload)
  end

  def ai_motivational_message
    payload = {
      model: "gpt-3.5-turbo", 
      max_tokens: 100,
      messages: [
        {
          role: "system",
          content: "You are a helpful assistant."
        },
        {
          role: "user",
          content: "Please provide a brief motivational message for a user to stay on task and get through their chores.
                    Ensure you complete the task breakdown in 75 tokens or less. 
                    Don't display the amount of tokens used.
                    Be terse but affable."
        }
      ]
    }.to_json

    get_url('/v1/chat/completions', payload)
  end
end