FactoryBot.define do
  factory :task do
    name { "#{Faker::Verb.base} #{Faker::House.room}" }
    category { Task.categories.keys.sample } # Assume Task model has an enum named 'categories'
    mandatory { Faker::Boolean.boolean }
    event_date { Faker::Time.forward(days: 30, period: :morning) }
    frequency { Task.frequencies.keys.sample } # Assume Task model has an enum named 'frequencies'
    time_needed { Faker::Number.number(digits: 2) }
    user_id { Faker::Number.number(digits: 3) }
    notes { Faker::Hipster.sentence }

    # Define traits for enum (only if you are not using traits_for_enum)
    trait :rest do
      category { "rest" }
    end
    
    trait :hobby do
      category { "hobby" }
    end
    
    trait :chore do
      category { "chore" }
    end
    
    trait :one_time do
      frequency { "one_time" }
    end
    
    trait :daily do
      frequency { "daily" }
    end
    
    trait :monthly do
      frequency { "monthly" }
    end
    
    trait :annual do
      frequency { "annual" }
    end
    
    trait :weekly do
      frequency { "weekly" }
    end
    # ... similarly for other enums
  end
end



# FactoryBot.define do
#   factory :task do
#       name { "#{Faker::Verb.base} #{Faker::House.room}" }
#       category { Task.categories.keys.sample }
#       mandatory { {Faker::Boolean.boolean} }
#       event_date { {Faker::Address.city} }
#       frequency { Task.frequencies.keys.sample }
#       time_needed { Faker::Number.number(digits: 2) }
#       user_id { Faker::Number.number(digits: 3) }
#       notes { Faker::Hipster.sentence }
#   end
# end
