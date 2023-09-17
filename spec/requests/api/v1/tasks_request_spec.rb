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

  describe "task show" do
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

    it "returns 404 status and descriptive error message if invalid id is passed" do
      id = 123123123123
      get "/api/v1/users/:id/tasks/#{id}"

      expect(response.status).to eq(404)
      expect{Task.find(id)}.to raise_error(ActiveRecord::RecordNotFound)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Task with 'id'=123123123123")
    end
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

    it "does not create a new task and returns status code 400 if invalid params passed" do
      task_params = ({
        "category": "chore",
        "time_needed": 20,
        "user_id": 523
      })
      request = post "/api/v1/users/523/tasks", params: task_params, as: :json

      expect{ request }.to_not change(Task, :count)
      expect{ Task.create!(task_params) }.to raise_error(ActiveRecord::RecordInvalid)

      request
    
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:status]).to eq("400")
      expect(data[:errors].first[:title]).to eq("Validation failed: Name can't be blank")
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

    it "does not update a task and returns status code 400 if invalid params passed" do
      task = @task_1
      previous_name = @task_1.name
      task_params = ({ "name": "" })

      patch "/api/v1/users/523/tasks/#{@task_1.id}", params: task_params, as: :json

      expect(task.name).to_not eq("")
      expect(task.name).to eq(previous_name)
      expect{ task.update!(task_params) }.to raise_error(ActiveRecord::RecordInvalid)
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:status]).to eq("400")
      expect(data[:errors].first[:title]).to eq("Validation failed: Name can't be blank")
    end

    it "does not update a task and returns status code 404 if invalid id passed" do
      id = 123123123123
      task_params = { "name": "Walk the puppy" }

      expect{Task.find(id)}.to raise_error(ActiveRecord::RecordNotFound)

      patch "/api/v1/users/523/tasks/#{id}", params: task_params, as: :json

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Task with 'id'=123123123123")
    end

    it "updates a completed task" do
      task = create(:task, frequency: "weekly")
      expect(task.completed).to eq(nil)

      patch "/api/v1/users/#{task.user_id}/tasks/#{task.id}", params: {completed: true}
      task.reload
      expect(task.completed).to_not eq(nil)
    end

    it "deletes a task if completed and frequency is one_time" do
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, frequency: "one_time")
      task = user1_tasks.first
      expect{Task.find(task.id)}.to_not raise_error(ActiveRecord::RecordNotFound)

      patch "/api/v1/users/#{task.user_id}/tasks/#{task.id}", params: {completed: true}
      expect{Task.find(task.id)}.to raise_error(ActiveRecord::RecordNotFound)
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
      
    it "will raise a 404 error when invalid id is passed in" do
      id = 123123123123
  
      delete "/api/v1/users/1/tasks/#{id}"
  
      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
  
      data = JSON.parse(response.body, symbolize_names: true)
  
      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Task with 'id'=123123123123")
    end
  end

  describe "get daily_tasks" do
    it "will get the tasks for the day" do
      user1_tasks = FactoryBot.create_list(:task, 20, user_id: 1)
      user2_tasks = FactoryBot.create_list(:task, 20, user_id: 2)
      get "/api/v1/users/1/daily_tasks", params: {mood: "good"}
      expect(response).to be_successful
      tasks = JSON.parse(response.body, symbolize_names: true)
      
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
  end
end