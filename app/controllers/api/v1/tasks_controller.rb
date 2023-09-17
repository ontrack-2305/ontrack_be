class Api::V1::TasksController < ApplicationController
  def create
    render json: TaskSerializer.new(Task.create!(task_params)), status: 201
  end

  def index
    render json: TaskSerializer.new(Task.all)
  end

  def show
    render json: TaskSerializer.new(Task.find(params[:id]))
  end

  def update
    if params[:completed] == "true"
      task = Task.find(params[:id])
      task.update!(completed: Time.now)
      task.destroy! if task.frequency == "one_time"
      # may need to add the method for getting daily_tasks endpoint here
      # or refresh page and get daily_tasks endpoint again without the completed task
    else !params[:completed]
      task = Task.find(params[:id])
      task.update!(task_params)
    end
    render json: TaskSerializer.new(task)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    render json: TaskSerializer.new(task), status: 204
  end

  def daily_tasks
    tasks = Task.get_tasks_for_mood(params[:mood], params[:user_id])
    render json: TaskSerializer.new(tasks)
  end

  private
  def task_params
    params.permit(:name, :category, :mandatory, :event_date, :frequency, :time_needed, :user_id, :notes)
  end
end