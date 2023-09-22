class Task < ApplicationRecord
  validates_presence_of :name, :category, :time_needed, :user_id
  enum category: { rest: 0, hobby: 1, chore: 2 }
  enum frequency: { once: 0, daily: 1, weekly: 2, monthly: 3, annual: 4 }

  def self.viable_tasks(user_id)
    user_tasks = Task.all.where(user_id: user_id)
    viable_tasks = []
    one_time_tasks = user_tasks.where(frequency: "once")
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

  def same_date?
    if event_date != nil && event_date != ""
      event_date = DateTime.parse(self.event_date) 
      event_date.day == Time.now.day && event_date.month == Time.now.month && event_date.year == Time.now.year
    else
      false
    end
  end

  def self.tasks_by_category(user_id)
    viable_tasks = Task.viable_tasks(user_id)
    tasks_by_category = {
      dated_tasks: viable_tasks.select { |task| task.same_date? && task.skipped != true },
      mandatory_tasks: viable_tasks.select { |task| task.mandatory == true && task.skipped != true && task.same_date? != true},
      rest_tasks: viable_tasks.select { |task| task.category == "rest" && task.mandatory != true && task.skipped != true && task.same_date? != true},
      hobby_tasks: viable_tasks.select { |task| task.category == "hobby" && task.mandatory != true && task.skipped != true && task.same_date? != true},
      chore_tasks: viable_tasks.select { |task| task.category == "chore" && task.mandatory != true && task.skipped != true && task.same_date? != true},
      skipped_tasks: viable_tasks.select { |task| task.skipped == true}
    }
    tasks_by_category
  end

  def self.good_day_tasks(user_id)
    tasks_by_category = Task.tasks_by_category(user_id)
    tasks_for_day = []
    tasks_for_day << tasks_by_category[:dated_tasks]
    tasks_for_day << tasks_by_category[:mandatory_tasks]
    while tasks_by_category[:chore_tasks].any?
      chore_task_1 = tasks_by_category[:chore_tasks].shift
      tasks_for_day << chore_task_1
      hobby_task_1 = tasks_by_category[:hobby_tasks].shift
      tasks_for_day << hobby_task_1
      restful_task_1 = tasks_by_category[:rest_tasks].shift
      tasks_for_day << restful_task_1
    end
    while tasks_by_category[:hobby_tasks].any?
      hobby_task_1 = tasks_by_category[:hobby_tasks].shift
      tasks_for_day << hobby_task_1
      restful_task_1 = tasks_by_category[:rest_tasks].shift
      tasks_for_day << restful_task_1
    end
    while tasks_by_category[:rest_tasks].any?
      restful_task_1 = tasks_by_category[:rest_tasks].shift
      tasks_for_day << restful_task_1
    end
    tasks_for_day << tasks_by_category[:skipped_tasks]
    tasks_for_day.flatten.compact
  end

  def self.meh_day_tasks(user_id)
    tasks_by_category = Task.tasks_by_category(user_id)
    tasks_for_day = []
    tasks_for_day << tasks_by_category[:dated_tasks]
    tasks_for_day << tasks_by_category[:mandatory_tasks]
    while tasks_by_category[:hobby_tasks].any?
      hobby_task_1 = tasks_by_category[:hobby_tasks].shift
      tasks_for_day << hobby_task_1
      restful_task_1 = tasks_by_category[:rest_tasks].shift
      tasks_for_day << restful_task_1
    end
    while tasks_by_category[:rest_tasks].any?
      restful_task_1 = tasks_by_category[:rest_tasks].shift
      tasks_for_day << restful_task_1
    end
    tasks_for_day << tasks_by_category[:skipped_tasks]
    tasks_for_day.flatten.compact
  end

  def self.bad_day_tasks(user_id)
    tasks_by_category = Task.tasks_by_category(user_id)
    tasks_for_day = []
    tasks_for_day << tasks_by_category[:dated_tasks]
    tasks_for_day << tasks_by_category[:mandatory_tasks]
    while tasks_by_category[:rest_tasks].any?
      restful_task_1 = tasks_by_category[:rest_tasks].shift
      tasks_for_day << restful_task_1
    end
    tasks_for_day << tasks_by_category[:skipped_tasks]
    tasks_for_day.flatten.compact
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

  def self.filter_by(params)
    tasks = Task.where(user_id: params[:user_id])
    tasks = tasks.where(mandatory: params[:search_params][:mandatory]) if params[:search_params][:mandatory]
    tasks = tasks.where(category: params[:search_params][:category]) if params[:search_params][:category]
    tasks = tasks.where(frequency: params[:search_params][:frequency]) if params[:search_params][:frequency]
    tasks
  end    
end