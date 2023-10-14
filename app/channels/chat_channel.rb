class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def start
    loop do
      # Check the shared storage for new notifications (e.g., from the database)
      notification = Notification.last # Replace with your actual query
      if notification
        # Broadcast the notification to the WebSocket channel
        ActionCable.server.broadcast("chat_channel", notification.content)
      end

      sleep 2.minutes # Adjust the interval as needed
    end
  end
end
