class Task < ApplicationRecord
  validates_presence_of :name, :category, :time_needed, :user_id

  enum category: { rest: 0, hobby: 1, chore: 2 }
  enum frequency: { once: 0, daily: 1, weekly: 2, monthly: 3, annual: 4 }
end