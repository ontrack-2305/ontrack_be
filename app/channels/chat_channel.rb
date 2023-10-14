class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def start
    loop do
      response = AiService.new.ai_motivational_message
      notification = response[:choices][0][:message][:content]
      if notification
        ActionCable.server.broadcast("chat_channel", notification)
      end
      # sleep 1.hour
      sleep 2.minutes 
    end
  end
end
