require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :type }
    it { should validate_presence_of :time_needed }
  end
end