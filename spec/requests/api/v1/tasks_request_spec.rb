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

  it "gets a list of all tasks" do
    get "/api/v1/users/1/tasks"

    expect(response).to be_successful
    
    tasks = JSON.parse(response.body, symbolize_names: true)
    
    expect(tasks[:data].count).to eq(5)
    
    tasks[:data].each do |task|
      expect(task).to have_key(:id)
      expect(task[:id]).to be_a(String)

      expect(task[:attributes]).to have_key(:name)
      expect(task[:attributes][:name]).to be_a(String)

      expect(task[:attributes]).to have_key(:category)
      expect(task[:attributes][:category]).to be_a(String)

      expect(task[:attributes]).to have_key(:mandatory)
      expect(task[:attributes][:mandatory]).to be_in([true, false])

      expect(task[:attributes]).to have_key(:event_date)
      expect(task[:attributes][:event_date]).to be_a(String)

      expect(task[:attributes]).to have_key(:frequency)
      expect(task[:attributes][:frequency]).to be_a(String)

      expect(task[:attributes]).to have_key(:time_needed)
      expect(task[:attributes][:time_needed]).to be_a(Integer)

      expect(task[:attributes]).to have_key(:user_id)
      expect(task[:attributes][:user_id]).to be_a(Integer)

      expect(task[:attributes]).to have_key(:notes)
      expect(task[:attributes][:notes]).to be_a(String)
    end
  end

  it "gets a single task" do
    get "/api/v1/users/1/tasks/#{@task_1.id}"

    expect(response).to be_successful
    
    task = JSON.parse(response.body, symbolize_names: true)

    expect(task.count).to eq(1)
    
      expect(task[:data]).to have_key(:id)
      expect(task[:data][:id]).to be_a(String)

      expect(task[:data][:attributes]).to have_key(:name)
      expect(task[:data][:attributes][:name]).to be_a(String)

      expect(task[:data][:attributes]).to have_key(:category)
      expect(task[:data][:attributes][:category]).to be_a(String)

      expect(task[:data][:attributes]).to have_key(:mandatory)
      expect(task[:data][:attributes][:mandatory]).to be_in([true, false])

      expect(task[:data][:attributes]).to have_key(:event_date)
      expect(task[:data][:attributes][:event_date]).to be_a(String)

      expect(task[:data][:attributes]).to have_key(:frequency)
      expect(task[:data][:attributes][:frequency]).to be_a(String)

      expect(task[:data][:attributes]).to have_key(:time_needed)
      expect(task[:data][:attributes][:time_needed]).to be_a(Integer)

      expect(task[:data][:attributes]).to have_key(:user_id)
      expect(task[:data][:attributes][:user_id]).to be_a(Integer)

      expect(task[:data][:attributes]).to have_key(:notes)
      expect(task[:data][:attributes][:notes]).to be_a(String)
  end

  describe "create a task" do
    it "returns newly created task resource and a 201 code" do
      task_params = ({
        "name": "Fold Laundry",
        "category": "chore",
        "time_needed": 20,
        "user_id": 523
      })
      
      post "/api/v1/users/1/tasks", params: task_params, as: :json

      created_task = Task.last
      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(created_task.name).to eq(task_params[:name])
      expect(created_task.category).to eq(task_params[:category])
      expect(created_task.time_needed).to eq(task_params[:time_needed])
      expect(created_task.frequency).to eq("one_time")
    end
  end

  describe "update a task" do
    it "updates an existing task with any parameters sent in via the body" do
      id = @task_1.id
      previous_name = @task_1.name
      task_params = { "name": "Walk Luca Dog" }

      patch "/api/v1/users/#{@task_1.user_id}/tasks/#{id}", params: task_params, as: :json
      task = Task.find_by(id: id)

      expect(response).to have_http_status(200)
      expect(task.name).to_not eq(previous_name)
      expect(task.name).to eq("Walk Luca Dog")
    end
  end

  describe "delete a task" do
    it "will destroy the task and return a 204 status code" do
      task = create(:task)
      id = task.id
      expect{ delete "/api/v1/users/#{task.user_id}/tasks/#{task.id}" }.to change(Task, :count).by(-1)
  
      delete "/api/v1/users/#{task.user_id}/tasks/#{task.id}"
      
      expect{Task.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
  end
end