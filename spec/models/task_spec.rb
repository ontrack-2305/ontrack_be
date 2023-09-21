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
    it "should return the tasks for a good day" do
      user1_tasks = FactoryBot.create_list(:task, 20, user_id: 1)
      user2_tasks = FactoryBot.create_list(:task, 20, user_id: 2)

      
    end

    it "only includes viable tasks" do
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1)
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now, frequency: "daily")
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now - 2.days, frequency: "daily")
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now - 8.days, frequency: "weekly")
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now - 4.days, frequency: "weekly")
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now - 8.days, frequency: "monthly")
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now - 2.months, frequency: "monthly")
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now - 6.months, frequency: "annual")
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, completed: Time.now - 2.years, frequency: "annual")
      user2_tasks = FactoryBot.create_list(:task, 10, user_id: 2)
    end
  end

  describe "instance methods" do
    it "returns tasks for the day" do
      user1_tasks = FactoryBot.create_list(:task, 20, user_id: 1)
      user1_tasks = FactoryBot.create_list(:task, 5, user_id: 1, skipped: true)
      user1_tasks = FactoryBot.create_list(:task, 1, user_id: 1, event_date: Time.now)
      user2_tasks = FactoryBot.create_list(:task, 20, user_id: 2)
      Task.tasks_by_category(1)
    end
  end
end