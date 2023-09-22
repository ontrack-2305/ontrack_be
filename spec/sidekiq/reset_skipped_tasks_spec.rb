require "rails_helper"

RSpec.describe ResetSkippedTasksJob do
  it "has method called perform" do
    job = ResetSkippedTasksJob.new
    expect(job).to respond_to(:perform)
  end

  it "queues the job" do
    create_list(:task, 5, skipped: true)
    expect { ResetSkippedTasksJob.perform_async }.to change(ResetSkippedTasksJob.jobs, :size).by(1)
    expect(ResetSkippedTasksJob.new.perform).to eq(5)
  end

  it "changes skipped tasks to true" do
    task = create(:task, :skipped => true)

    expect do
      ResetSkippedTasksJob.new.perform
      described_class.drain 
    end.to change { task.reload.skipped }.from(true).to(false)
  end
end