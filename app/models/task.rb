class Task < ApplicationRecord
  validates_presence_of :name, :category, :time_needed, :user_id

  enum category: { rest: 0, hobby: 1, chore: 2 }
  enum frequency: { one_time: 0, daily: 1, weekly: 2, monthly: 3, annual: 4 }

  def self.viable_tasks(user_id)
    user_tasks = Task.all.where(user_id: user_id)
    viable_tasks = []
    one_time_tasks = user_tasks.where(frequency: "one_time")
    daily_tasks = user_tasks.where(frequency: "daily")
    weekly_tasks = user_tasks.where(frequency: "weekly")
    monthly_tasks = user_tasks.where(frequency: "monthly")
    annual_tasks = user_tasks.where(frequency: "annual")
    
    viable_tasks << user_tasks.where(completed: nil)
    viable_tasks << daily_tasks.where("completed < ?", Time.now - 1.days)
    viable_tasks << weekly_tasks.where("completed < ?", Time.now - 7.days)
    viable_tasks << monthly_tasks.where("completed < ?", Time.now - 1.month)
    viable_tasks << annual_tasks.where("completed < ?", Time.now - 1.year)
    viable_tasks = viable_tasks.flatten
    viable_tasks
  end



  def self.tasks_by_category(user_id)
    viable_tasks = Task.viable_tasks(user_id)
    tasks_by_category = {
      rest_tasks: viable_tasks.select { |task| task.category == "rest" },
      hobby_tasks: viable_tasks.select { |task| task.category == "hobby" },
      chore_tasks: viable_tasks.select { |task| task.category == "chore" }
    }
    tasks_by_category
  end

  def self.good_day_tasks(user_id)
    tasks_by_category = Task.tasks_by_category(user_id)
    tasks_for_day = []
    total_task_time = 0
    while total_task_time < 500
      chore_task_1 = tasks_by_category[:chore_tasks].sample
      chore_task_2 = tasks_by_category[:chore_tasks].sample
      hobby_task_1 = tasks_by_category[:hobby_tasks].sample
      restful_task_1 = tasks_by_category[:rest_tasks].sample
      total_task_time += chore_task_1.time_needed
      tasks_for_day << chore_task_1
      total_task_time += chore_task_2.time_needed
      tasks_for_day << chore_task_2
      total_task_time += hobby_task_1.time_needed
      tasks_for_day << hobby_task_1
      total_task_time += restful_task_1.time_needed
      tasks_for_day << restful_task_1
    end
    tasks_for_day
  end

  def self.meh_day_tasks(user_id)
    tasks_by_category = Task.tasks_by_category(user_id)
    tasks_for_day = []
    total_task_time = 0
    while total_task_time < 400
      chore_task_1 = tasks_by_category[:chore_tasks].sample
      hobby_task_1 = tasks_by_category[:hobby_tasks].sample
      restful_task_1 = tasks_by_category[:rest_tasks].sample
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
    tasks_by_category = Task.tasks_by_category(user_id)
    tasks_for_day = []
    total_task_time = 0
    while total_task_time < 300
      hobby_task_1 = tasks_by_category[:hobby_tasks].sample
      restful_task_1 = tasks_by_category[:rest_tasks].sample
      total_task_time += hobby_task_1.time_needed
      tasks_for_day << hobby_task_1
      total_task_time += restful_task_1.time_needed
      tasks_for_day << restful_task_1
    end
    tasks_for_day
  end

  def self.get_tasks_for_mood(mood, user_id)
    if mood == "good"
      tasks = Task.good_day_tasks(user_id)
    elsif mood == "meh"
      tasks = Task.meh_day_tasks(user_id)
    else
      tasks = Task.bad_day_tasks(user_id)
    end
    tasks
  end
  # should annual events and holidays come from google calendar api?
  # skip just pushes task to end of daily task array?

  # Mood is an indicator of how many bonus tasks to complete in a day 
end