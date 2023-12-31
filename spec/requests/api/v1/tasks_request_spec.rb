require "rails_helper"

RSpec.describe "Tasks API" do
  before do
    create_list(:task, 5, user_id: 123)
    @task_1 = Task.all[0]
    @task_2 = Task.all[1]
    @task_3 = Task.all[2]
    @task_4 = Task.all[3]
    @task_5 = Task.all[4]
    @t1 = Task.create({ "name": "wash dishes", "category": "chore", "time_needed": 20, "user_id": 523, "mandatory": false })
    @t2 = Task.create({ "name": "vacuum", "category": "chore", "time_needed": 30, "user_id": 523, "frequency": "weekly", "mandatory": false })
    @t3 = Task.create({ "name": "walk dog", "category": "rest", "time_needed": 20, "user_id": 523, "mandatory": true, "frequency": "daily" })
    @t4 = Task.create({ "name": "paint", "category": "hobby", "time_needed": 120, "user_id": 523, "mandatory": true, "frequency": "weekly" })
  end

  describe "task index" do
    it "returns a list of all the user's tasks" do
      get "/api/v1/users/#{@task_1.user_id}/tasks"

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

        expect(task[:attributes]).to have_key(:user_id)
        expect(task[:attributes][:user_id]).to eq(123)

        expect(task[:attributes]).to have_key(:notes)
        expect(task[:attributes][:notes]).to be_a(String)
      end
    end

    it "does not show any other user's tasks" do
      get "/api/v1/users/123/tasks"

      expect(response).to be_successful
      
      tasks = JSON.parse(response.body, symbolize_names: true)

      expect(Task.count).to eq(9)
      expect(tasks[:data].count).to eq(5)
      expect(tasks[:data].all? { |task| task[:attributes][:user_id] = 123 }).to eq(true)
    end

    it "filters for mandatory tasks for that user" do
      get "/api/v1/users/523/tasks", params: {search_params: {mandatory: true}}
      expect(response).to be_successful
      
      tasks = JSON.parse(response.body, symbolize_names: true)

      expect(tasks[:data].count).to eq(2)
      expect(tasks[:data][0][:attributes][:name]).to eq("walk dog")
      expect(tasks[:data][1][:attributes][:name]).to eq("paint")
      expect(tasks[:data].all? { |task| task[:attributes][:user_id] == 523 }).to eq(true)
    end

    it "filters by category" do
      get "/api/v1/users/523/tasks", params: {search_params: {category: "chore"}}
      expect(response).to be_successful

      tasks = JSON.parse(response.body, symbolize_names: true)
      expect(tasks[:data].count).to eq(2)
      expect(tasks[:data][0][:attributes][:name]).to eq("wash dishes")
      expect(tasks[:data][1][:attributes][:name]).to eq("vacuum")
      
      get "/api/v1/users/523/tasks", params: {search_params: {category: "hobby"}}
      tasks = JSON.parse(response.body, symbolize_names: true)
      expect(tasks[:data].count).to eq(1)
      expect(tasks[:data][0][:attributes][:name]).to eq("paint")
      expect(tasks[:data].all? { |task| task[:attributes][:user_id] == 523 }).to eq(true)
    end

    it "filters by frequency" do
      get "/api/v1/users/523/tasks", params: {search_params: {frequency: "weekly"}}
      expect(response).to be_successful

      tasks = JSON.parse(response.body, symbolize_names: true)
      expect(tasks[:data].count).to eq(2)
      expect(tasks[:data][0][:attributes][:name]).to eq("vacuum")
      expect(tasks[:data][1][:attributes][:name]).to eq("paint")
      expect(tasks[:data].all? { |task| task[:attributes][:user_id] == 523 }).to eq(true)
    end

    it "filters by multiple criteria" do
      get "/api/v1/users/523/tasks", params: {search_params: {frequency: "weekly", category: "hobby"}}
      expect(response).to be_successful

      tasks = JSON.parse(response.body, symbolize_names: true)
      expect(tasks[:data].count).to eq(1)
      expect(tasks[:data][0][:attributes][:name]).to eq("paint")
    end
  end

  describe "task show" do
    it "gets a single task" do
      get "/api/v1/users/123/tasks/#{@task_1.id}"

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

        expect(task[:data][:attributes]).to have_key(:user_id)
        expect(task[:data][:attributes][:user_id]).to be_a(Integer)

        expect(task[:data][:attributes]).to have_key(:notes)
        expect(task[:data][:attributes][:notes]).to be_a(String)
    end

    it "returns 404 status and descriptive error message if invalid id is passed" do
      id = 123123123123
      get "/api/v1/users/123/tasks/#{id}"

      expect(response).to have_http_status(404)
      expect{Task.find(id)}.to raise_error(ActiveRecord::RecordNotFound)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:detail]).to eq("Couldn't find Task with 'id'=123123123123")
    end
  end

  describe "create a task" do
    it "returns newly created task resource and a 201 code" do
      task_params = ({
        "name": "Fold Laundry",
        "category": "chore",
        "time_needed": 20,
        "user_id": 523,
        "frequency": "once"
      })
      
      post "/api/v1/users/1/tasks", params: task_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      created_task = Task.last

      expect(JSON.parse(response.body)["message"]).to eq("'Fold Laundry' added!")

      expect(created_task.name).to eq("Fold Laundry")
      expect(created_task.category).to eq("chore")
      expect(created_task.frequency).to eq("once")
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
      expect(response).to have_http_status(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:detail]).to eq("Validation failed: Name can't be blank")
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
      expect(response).to have_http_status(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:detail]).to eq("Validation failed: Name can't be blank")
    end

    it "does not update a task and returns status code 404 if invalid id passed" do
      id = 123123123123
      task_params = { "name": "Walk the puppy" }

      expect{Task.find(id)}.to raise_error(ActiveRecord::RecordNotFound)

      patch "/api/v1/users/523/tasks/#{id}", params: task_params, as: :json

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors].first[:detail]).to eq("Couldn't find Task with 'id'=123123123123")
    end

    it "updates a completed task and sets skipped to false" do
      task = create(:task, frequency: "weekly", skipped: true)
      expect(task.completed).to eq(nil)
      expect(task.skipped).to eq(true)

      patch "/api/v1/users/#{task.user_id}/tasks/#{task.id}", params: {completed: true}
      task.reload
      expect(task.completed).to_not eq(nil)
      expect(task.completed).to be_a(ActiveSupport::TimeWithZone)
      expect(task.skipped).to eq(false)
    end

    it "updates a skipped task" do
      task = create(:task, frequency: "weekly")
      expect(task.skipped).to eq(false)

      patch "/api/v1/users/#{task.user_id}/tasks/#{task.id}", params: {skipped: true}
      task.reload
      expect(task.skipped).to eq(true)
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
  
      expect(data[:errors].first[:detail]).to eq("Couldn't find Task with 'id'=123123123123")
    end
  end

  describe "get daily_tasks" do
    it "will get the tasks for the day" do
      create_list(:task, 20, user_id: 1)
      create_list(:task, 5, user_id: 1, skipped: true)
      create_list(:task, 20, user_id: 2)

      get "/api/v1/users/1/daily_tasks", params: {mood: "good"}
      expect(response).to be_successful

      tasks = JSON.parse(response.body, symbolize_names: true)

      expect(tasks[:data].count).to eq(25)

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

        expect(task[:attributes]).to have_key(:user_id)
        expect(task[:attributes][:user_id]).to eq(1)

        expect(task[:attributes]).to have_key(:notes)
        expect(task[:attributes][:notes]).to be_a(String)

        expect(task[:attributes]).to have_key(:skipped)
        expect(task[:attributes][:skipped]).to be_in([true, false])
      end

      skipped_tasks = tasks[:data][20..24]
      expect(skipped_tasks.all? { |task| task[:attributes][:skipped] }).to eq(true)
    end
  end
end