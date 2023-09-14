# FactoryBot.define do
#   factory :task do
#       name { "#{Faker::verb.base} #{Faker::house.room}" }
#       traits_for_enum :category, [:rest, :hobby, :chore]
#       mandatory { {Faker::Boolean.boolean} }
#       event_date { {Faker::Address.city} }
#       traits_for_enum :frequency, [:one_time, :daily, :weekly, :monthly, :annual]
#       time_needed { Faker }
#       user_id { "#{Faker::Address.latitude}" }
#       notes { "#{Faker::Address.longitude}" }
#   end
# end
