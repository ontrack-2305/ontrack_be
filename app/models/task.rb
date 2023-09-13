class Task < ApplicationRecord
  validates_presence_of :name, :type, :time_needed

  enum type: { rest: 0, hobby: 1, chore: 2 }
  enum frequency: { one_time: 0, daily: 1, weekly: 2, monthly: 3, annual: 4 }
end