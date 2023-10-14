class HourlyNotificationWorkerJob
  include Sidekiq::Job

  def perform
    response = AiService.new.ai_motivational_message
    notification_message = response[:choices][0][:message][:content]
    Notification.create(content: notification_message)  
  end
end
