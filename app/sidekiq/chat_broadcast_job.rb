class ChatBroadcastJob
  include Sidekiq::Job

  def perform
    response = AiService.new.ai_motivational_message
    notification = response[:choices][0][:message][:content]
    if notification
      ActionCable.server.broadcast("chat_channel", notification)
    end
  end
end