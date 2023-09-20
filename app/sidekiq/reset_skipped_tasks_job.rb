class ResetSkippedTasksJob
  include Sidekiq::Job

  def perform
    Task.where(skipped: true).update_all(skipped: false)
  end
end
