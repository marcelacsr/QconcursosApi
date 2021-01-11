FactoryBot.define do
  factory :question do
    sequence(:answer) { 'A' }
    sequence(:daily_access) { |n| 100 + n }
    sequence(:discipline) { |n| "discipline_#{n}" }
    sequence(:statement) { |n| "statement_#{n}" }
    sequence(:text) { |n| "text_#{n}" }
    created_at { Date.today }
  end
end
