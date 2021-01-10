class QuestionsController < ApplicationController
  def index
    disciplines = Question.order_sum_by_discipline
    render json: disciplines.to_json
  end
end

# Disciplinas com questões mais quentes:
# Listar as disciplinas onde as questões
# foram as mais acessadas nas ultimas 24H
#
# Question.where(daily_access: )
#   scope :ordenar, -> { order('daily_access desc') }
#
# Mais acessadas por periodo:
# Listar as questões mais acessadas por semana/mês/ano

# date e times_accessed

# semana
# mes
# ano
