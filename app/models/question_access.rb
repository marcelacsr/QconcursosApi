class QuestionAccess < ApplicationRecord
  belongs_to :question

  validates :date, :question, presence: true
  validates :times_accessed, presence: true, numericality: { only_integer: true }

  # Mais acessadas por periodo:
  # Listar as questões mais acessadas por semana/mês/ano

  # date e times_accessed

  # semana
  # mes
  # ano
  #
  # date= '2019-07-20 or 2019-07 or 2019'
  # retorno: question id e soma de times accessed

  scope :by_year, lambda { |date|
    where(date: date.beginning_of_year..date.at_end_of_year).group(:question_id).sum('times_accessed')
  }

  scope :by_month, lambda { |date|
    where(date: date.beginning_of_month..date.at_end_of_month).group(:question_id).sum('times_accessed')
  }

  scope :by_week, lambda { |date|
    where(date: date.beginning_of_week..date.at_end_of_week).group(:question_id).sum('times_accessed')
  }
end
