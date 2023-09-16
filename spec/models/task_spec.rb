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
    it { should define_enum_for(:frequency).with_values([:one_time, :daily, :weekly, :monthly, :annual]) }
  end

  describe "class methods" do
    it "should return the tasks for a good day" do
      user1_tasks = FactoryBot.create_list(:task, 20, user_id: 1)
      user2_tasks = FactoryBot.create_list(:task, 20, user_id: 2)

      Task.good_day_tasks(1)
      # break day into 12 hours, 2 hour break midday
      # two chunks of tasks totalling 5 hours each
      # 2 chores 1 hobby 1 rest

      # create an empty array for objects and an empty array for task time_needed. Add tasks to algorithm until time_needed = 5 hours
    end
  end
end