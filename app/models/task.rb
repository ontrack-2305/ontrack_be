class Task < ApplicationRecord
  validates_presence_of :name, :category, :time_needed, :user_id

  enum category: { rest: 0, hobby: 1, chore: 2 }
  enum frequency: { one_time: 0, daily: 1, weekly: 2, monthly: 3, annual: 4 }

  def self.viable_tasks(user_id)
    @user_tasks = Task.all.where(user_id: user_id)
    @viable_tasks = []
    one_time_tasks = @user_tasks.where(frequency: "one_time")
    daily_tasks = @user_tasks.where(frequency: "daily")
    weekly_tasks = @user_tasks.where(frequency: "weekly")
    monthly_tasks = @user_tasks.where(frequency: "monthly")
    annual_tasks = @user_tasks.where(frequency: "annual")
    
    @viable_tasks << @user_tasks.where(completed: nil)
    @viable_tasks << daily_tasks.where("completed < ?", Time.now - 1.days)
    @viable_tasks << weekly_tasks.where("completed < ?", Time.now - 7.days)
    @viable_tasks << monthly_tasks.where("completed < ?", Time.now - 1.month)
    @viable_tasks << annual_tasks.where("completed < ?", Time.now - 1.year)
    @viable_tasks = @viable_tasks.flatten
  end



  def self.breakdown_tasks(user_id)
    Task.viable_tasks(user_id)
    @user_tasks = Task.all.where(user_id: user_id)
    @restful_tasks = @viable_tasks.where(category: "rest")
    @hobby_tasks = @viable_tasks.where(category: "hobby")
    @chore_tasks = @viable_tasks.where(category: "chore")
  end

  def self.good_day_tasks(user_id)
    Task.breakdown_tasks(user_id)
    tasks_for_day = []
    total_task_time = 0
    while total_task_time < 500
      chore_task_1 = @chore_tasks.sample
      chore_task_2 = @chore_tasks.sample
      hobby_task_1 = @hobby_tasks.sample
      restful_task_1 = @restful_tasks.sample
      total_task_time += chore_task_1.time_needed
      tasks_for_day << chore_task_1
      total_task_time += chore_task_2.time_needed
      tasks_for_day << chore_task_2
      total_task_time += hobby_task_1.time_needed
      tasks_for_day << hobby_task_1
      total_task_time += restful_task_1.time_needed
      tasks_for_day << restful_task_1
    end
    require 'pry'; binding.pry
    tasks_for_day
  end

  def self.meh_day_tasks(user_id)
    Task.breakdown_tasks(user_id)
    tasks_for_day = []
    total_task_time = 0
    while total_task_time < 400
      chore_task_1 = @chore_tasks.sample
      hobby_task_1 = @hobby_tasks.sample
      restful_task_1 = @restful_tasks.sample
      total_task_time += chore_task_1.time_needed
      tasks_for_day << chore_task_1
      total_task_time += hobby_task_1.time_needed
      tasks_for_day << hobby_task_1
      total_task_time += restful_task_1.time_needed
      tasks_for_day << restful_task_1
    end
    tasks_for_day
  end

  def self.bad_day_tasks(user_id)
    Task.breakdown_tasks(user_id)
    tasks_for_day = []
    total_task_time = 0
    while total_task_time < 300
      hobby_task_1 = @hobby_tasks.sample
      restful_task_1 = @restful_tasks.sample
      total_task_time += hobby_task_1.time_needed
      tasks_for_day << hobby_task_1
      total_task_time += restful_task_1.time_needed
      tasks_for_day << restful_task_1
    end
    tasks_for_day
  end

  # build out a def viable_task helper method that checks frequency against when it was last completed,
  # this will require a migration to add a completed with a date_time stamp
  #  viable_tasks = []
  #  one_time_tasks = user_tasks.where(frequency: "one_time")
  #  daily_tasks = user_tasks.where(frequency: "daily")
  #  weekly_tasks = user_tasks.where(frequency: "weekly")
  #  monthly_tasks = user_tasks.where(frequency: "monthly")
  #  annual_tasks = user_tasks.where(frequency: "annual")

  #  viable_tasks << daily_tasks.where(completion: nil)

  #  viable_tasks << daily_tasks.where("completion < ?", Time.now - 1.days)

  #  viable_tasks << weekly_tasks.where("completion < ?", Time.now - 7.days)

  #  viable_tasks << monthly_tasks.where("completion < ?", Time.now - 1.month)

  #  viable_tasks << annual_tasks.where("completion < ?", Time.now - 1.year)

  # incorporate a clause that states if event_date.day == Time.now.day || event_date == nil then shovel into viable task array

  # To store time of completion, create a request endpoint for task completion 
  # that checks if the completion param is there then adds Time.now to the completion column


  # should annual events and holidays come from google calendar api?
  # skip just pushes task to end of daily task array?

  # Mood is an indicator of how many bonus tasks to complete in a day 

end