FactoryBot.define do
  factory :task do
    name { "#{Faker::Verb.base} #{Faker::House.room}" }
    category { Task.categories.keys.sample } # Assume Task model has an enum named 'categories'
    mandatory { Faker::Boolean.boolean }
    event_date { Faker::Time.forward(days: 30) }
    frequency { Task.frequencies.keys.sample } # Assume Task model has an enum named 'frequencies'
    time_needed { Faker::Number.number(digits: 2) }
    user_id { Faker::Number.number(digits: 3) }
    notes { Faker::Hipster.sentence }
  end
end


