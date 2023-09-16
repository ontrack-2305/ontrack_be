class Task < ApplicationRecord
  validates_presence_of :name, :category, :time_needed, :user_id

  enum category: { rest: 0, hobby: 1, chore: 2 }
  enum frequency: { one_time: 0, daily: 1, weekly: 2, monthly: 3, annual: 4 }

  def self.breakdown_tasks(user_id)
    @user_tasks = Task.all.where(user_id: user_id)
    @restful_tasks = @user_tasks.where(category: "rest")
    @hobby_tasks = @user_tasks.where(category: "hobby")
    @chore_tasks = @user_tasks.where(category: "chore")
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
  #  one_time_tasks = user_tasks.where(frequency: one_time)
  #  daily_tasks = user_tasks.where(frequency: daily)
  #  weekly_tasks = user_tasks.where(frequency: weekly)
  #  monthly_tasks = user_tasks.where(frequency: monthly)
  #  annual_tasks = user_tasks.where(frequency: annual)
  #  viable_tasks << weekly_tasks.where(completion: nil)
  #  viable_tasks << weekly_tasks.where(:completion < Time.now - 7)



  # should annual events and holidays come from google calendar api?
end