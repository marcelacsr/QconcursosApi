class Question < ApplicationRecord
  has_many :question_accesses

  validates :answer, :daily_access, :discipline, :statement, :text,
            :created_at, presence: true
  validates :answer, length: { maximum: 1 }, inclusion: { in: %w[A B C D] }

  # Disciplinas com questões mais quentes:
  # Listar disciplinas onde as questões foram as mais acessadas nas ultimas 24H
  scope :order_sum_by_discipline, lambda {
    group('discipline').order('sum_daily_access DESC').sum('daily_access')
  }
end
