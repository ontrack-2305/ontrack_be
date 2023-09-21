class Api::V1::TasksController < ApplicationController
  def create
    TaskSerializer.new(Task.create!(task_params))
    render json: { message: "'#{Task.last.name}' added!" }, status: 201
  end

  def index
    if params[:search_params]
      render json: TaskSerializer.new(Task.filter_by(params[:search_params]))
    else
      render json: TaskSerializer.new(Task.where(user_id: params[:user_id]))
    end
  end

  def show
    render json: TaskSerializer.new(Task.find(params[:id]))
  end

  def update
    if params[:completed] == "true"
      task = Task.find(params[:id])
      task.update!(completed: Time.now, skipped: false)
    elsif params[:skipped] == "true"
      task = Task.find(params[:id])
      task.update!(skipped: true)
    else !params[:completed] && !params[:skipped]
      task = Task.find(params[:id])
      task.update!(task_params)
    end
    render json: { message: "Changes saved!" }
  end

  def destroy
    task = Task.find(params[:id])
    task_name = task.name
    task.destroy!
    render json: { message: "'#{task_name}' deleted." }
  end

  def daily_tasks
    tasks = Task.get_tasks_for_mood(params[:mood], params[:user_id])
    render json: TaskSerializer.new(tasks)
  end

  private
  def task_params
    params.permit(:name, :category, :mandatory, :event_date, :frequency, :time_needed, :user_id, :notes, :image)
  end
end