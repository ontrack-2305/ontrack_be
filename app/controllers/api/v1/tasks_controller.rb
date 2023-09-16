class Api::V1::TasksController < ApplicationController
  def create
    render json: TaskSerializer.new(Task.create!(task_params)), status: 201, message: "'#{Task.last.name}' added!"
  end

  def index
    render json: TaskSerializer.new(Task.where(user_id: params[:user_id]))
  end

  def show
    render json: TaskSerializer.new(Task.find(params[:id]))
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    render json: TaskSerializer.new(task), message: "Changes saved!"
  end

  def destroy
    task = Task.find(params[:id])
    task_name = task.name
    task.destroy!
    render json: TaskSerializer.new(task), status: 204, message: "'#{task_name}' deleted."
  end


  private
  def task_params
    params.permit(:name, :category, :mandatory, :event_date, :frequency, :time_needed, :user_id, :notes)
  end
end