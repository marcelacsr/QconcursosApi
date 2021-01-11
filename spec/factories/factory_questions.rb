FactoryBot.define do
  factory :question do
    sequence(:answer) { 'A' }
    sequence(:daily_access) { |n| 100 + n }
    discipline { 'discipline' }
    sequence(:statement) { |n| "statement_#{n}" }
    sequence(:text) { |n| "text_#{n}" }
    created_at { Date.today }
  end
end
