FactoryBot.define do
  factory :question_access do
    date { Date.today - 7.days }
    association :question
    times_accessed { 100 }
  end
end
