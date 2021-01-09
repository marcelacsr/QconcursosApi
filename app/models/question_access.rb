class QuestionAccess < ApplicationRecord
  belongs_to :question

  validates :date, :question, presence: true
  validates :times_accessed, presence: true, numericality: { only_integer: true }
end
