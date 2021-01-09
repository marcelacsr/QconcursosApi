class Question < ApplicationRecord
  has_many :question_accesses

  validates :answer, :daily_access, :discipline, :statement, :text,
            :created_at, presence: true
  validates :answer, length: { maximum: 1 } # include only [A, B, C, D, F]
end
