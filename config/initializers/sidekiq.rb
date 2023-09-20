require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }

  # Load scheduled jobs defined in sidekiq_schedule.yml
  schedule_file = "config/sidekiq_schedule.yml"

  if File.exist?(schedule_file)
    sidekiq_schedule = YAML.load_file(schedule_file)
    Sidekiq::Cron::Job.load_from_hash(sidekiq_schedule)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end