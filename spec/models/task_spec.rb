require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :category }
    it { should validate_presence_of :time_needed }
    it { should validate_presence_of :user_id }
  end

  describe "Enum Definitions" do
    it { should define_enum_for(:category).with_values([:rest, :hobby, :chore]) }
    it { should define_enum_for(:frequency).with_values([:once, :daily, :weekly, :monthly, :annual]) }
  end

  describe "class methods" do
    it "only includes viable tasks" do
      task1 = create(:task, user_id: 1, completed: Time.now, frequency: "daily")
      task2 = create(:task, user_id: 1, completed: Time.now - 2.days, frequency: "daily")
      task3 = create(:task, user_id: 1, completed: Time.now - 8.days, frequency: "weekly")
      task4 = create(:task, user_id: 1, completed: Time.now - 4.days, frequency: "weekly")
      task5 = create(:task, user_id: 1, completed: Time.now - 8.days, frequency: "monthly")
      task6 = create(:task, user_id: 1, completed: Time.now - 2.months, frequency: "monthly")
      task7 = create(:task, user_id: 1, completed: Time.now - 6.months, frequency: "annual")
      task8 = create(:task, user_id: 1, completed: Time.now - 2.years, frequency: "annual")
      user2_tasks = create_list(:task, 10, user_id: 2)

      viable_tasks = Task.viable_tasks(1)
      
      expect(viable_tasks).to be_an(Array)
      expect(viable_tasks.count).to eq(4)
      expect(viable_tasks).to match_array([task6, task2, task3, task8])
    end

    it "returns tasks ordered by category" do
      create_list(:task, 20, user_id: 1)

      categorized = Task.tasks_by_category(1)
      expect(categorized).to have_key(:dated_tasks)
      expect(categorized).to have_key(:mandatory_tasks)
      expect(categorized).to have_key(:rest_tasks)
      expect(categorized).to have_key(:hobby_tasks)
      expect(categorized).to have_key(:chore_tasks)
      expect(categorized).to have_key(:skipped_tasks)

      expect(categorized[:dated_tasks].all? {|task| task.same_date? && task.skipped == false }).to eq(true)
      expect(categorized[:mandatory_tasks].all? {|task| task.mandatory && task.skipped == false }).to eq(true)
      expect(categorized[:rest_tasks].all? {|task| task.category == "rest" && task.skipped == false }).to eq(true)
      expect(categorized[:hobby_tasks].all? {|task| task.category == "hobby" && task.skipped == false }).to eq(true)
      expect(categorized[:chore_tasks].all? {|task| task.category == "chore" && task.skipped == false }).to eq(true)
      expect(categorized[:skipped_tasks].all? {|task| task.skipped }).to eq(true)

      expect(categorized.values.flatten.count).to eq(20)
    end

    it "returns only mandatory and rest tasks on bad days" do
      create_list(:task, 15, category: "rest", user_id: 1)
      create_list(:task, 5, mandatory: true, user_id: 1)
      create_list(:task, 10, category: "hobby", mandatory: false, user_id: 1)
      create_list(:task, 5, category: "chore", mandatory: false, user_id: 1)

      tasks = Task.bad_day_tasks(1)
      expect(tasks).to be_an(Array)
      expect(tasks.count).to eq(20)
      tasks.each do |task|
        expect(task.category == "rest" || task.mandatory ).to eq(true)
      end
    end

    it "returns mandatory, hobby, and rest tasks on meh days" do
      create_list(:task, 15, category: "rest", user_id: 1, frequency: "daily")
      create_list(:task, 5, mandatory: true, user_id: 1, frequency: "daily")
      create_list(:task, 10, category: "hobby", mandatory: false, user_id: 1, frequency: "daily")
      create_list(:task, 5, category: "chore", mandatory: false, user_id: 1, frequency: "daily")

      tasks = Task.meh_day_tasks(1)
      
      expect(tasks).to be_an(Array)
      expect(tasks.count).to eq(30)
      tasks.each do |task|
        expect(task.category == "rest" || task.mandatory || task.category == "hobby" ).to eq(true)
      end
    end

    it "returns mandatory, hobby, rest, and chore tasks on good days" do
      create_list(:task, 15, category: "rest", user_id: 1, frequency: "daily")
      create_list(:task, 5, mandatory: true, user_id: 1, frequency: "daily")
      create_list(:task, 10, category: "hobby", mandatory: false, user_id: 1, frequency: "daily")
      create_list(:task, 5, category: "chore", mandatory: false, user_id: 1, frequency: "daily")

      tasks = Task.good_day_tasks(1)

      expect(Task.all).to match_array(tasks)
    end

    it "returns tasks by given mood" do
      create_list(:task, 15, category: "rest", user_id: 1)
      create_list(:task, 5, mandatory: true, user_id: 1)
      create_list(:task, 10, category: "hobby", mandatory: false, user_id: 1)
      create_list(:task, 5, category: "chore", mandatory: false, user_id: 1)

      expect(Task.get_tasks_for_mood("bad", 1)).to match_array(Task.bad_day_tasks(1))
      expect(Task.get_tasks_for_mood("good", 1)).to match_array(Task.good_day_tasks(1))
      expect(Task.get_tasks_for_mood("meh", 1)).to match_array(Task.meh_day_tasks(1))
    end

    it "can filter tasks by search queries" do
      create_list(:task, 50, user_id: 1)

      mandatory_tasks = Task.filter_by({search_params: {mandatory: true}})
      daily_tasks = Task.filter_by({search_params: {frequency: "daily"}})
      chore_tasks = Task.filter_by({search_params: {category: "chore"}})
      daily_mandatory_chore_tasks = Task.filter_by({search_params: {mandatory: true, frequency: "daily", category: "chore"}})

      expect(mandatory_tasks.all? { |task| task.mandatory }).to eq(true)
      expect(daily_tasks.all? { |task| task.frequency == "daily" }).to eq(true)
      expect(chore_tasks.all? { |task| task.category == "chore" }).to eq(true)
      expect(daily_mandatory_chore_tasks.all? { |task| task.frequency == "daily" && task.category == "chore" && task.mandatory }).to eq(true)
    end
  end

  describe "instance methods" do
    it "can check if event_date of task is today" do
      create(:task, event_date: Date.today)
      task1 = Task.last
      create(:task, event_date: Date.today + 4.days)
      task2 = Task.last
      create(:task, event_date: nil)
      task3 = Task.last

      expect(task1.same_date?).to eq(true)
      expect(task2.same_date?).to eq(false)
      expect(task3.same_date?).to eq(false)
    end
  end
end