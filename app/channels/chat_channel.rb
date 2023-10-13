class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end
end
