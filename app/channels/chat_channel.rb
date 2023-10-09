class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def speak(data)
    user_message = data["message"]
    response = AiService.new.fetch_chat_response(user_message)
    clean_response = {message: response[:choices][0][:message][:content]}.to_json
    ActionCable.server.broadcast("chat_channel", clean_response)
  end
end
