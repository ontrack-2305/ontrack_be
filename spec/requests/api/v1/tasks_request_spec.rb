require "rails_helper"

RSpec.describe "Tasks API" do
  before do
    create_list(:task, 5)
    @task_1 = Task.all[0]
    @task_2 = Task.all[1]
    @task_3 = Task.all[2]
    @task_4 = Task.all[3]
    @task_5 = Task.all[4]
  end

  xit "gets a list of all tasks" do
    get "/api/v1/tasks"

    expect(response).to be_successful
  end
end