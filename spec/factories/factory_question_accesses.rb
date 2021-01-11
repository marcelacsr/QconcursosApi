FactoryBot.define do
  factory :question_access do
    date { Date.today - 7.days }
    association :question
    sequence(:times_accessed) { |n| 100 + n }
  end
end
