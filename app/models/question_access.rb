class QuestionAccess < ApplicationRecord
  belongs_to :question

  validates :date, :question, presence: true
  validates :times_accessed, presence: true, numericality: { only_integer: true }

  scope :by_year, lambda { |date|
    where(date: date.beginning_of_year..date.at_end_of_year)
  }

  scope :by_month, lambda { |date|
    where(date: date.beginning_of_month..date.at_end_of_month)
  }

  scope :by_week, lambda { |date|
    where(date: date.beginning_of_week..date.at_end_of_week)
  }
end
