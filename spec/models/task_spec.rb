require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :category }
    it { should validate_presence_of :time_needed }
    it { should validate_presence_of :user_id }
  end

  describe "Enum Definitions" do
    it { should define_enum_for(:category).with([:rest, :hobby, :chore]) }
    it { should define_enum_for(:frequency).with([:one_time, :daily, :weekly, :monthly, :annual]) }
  end
end