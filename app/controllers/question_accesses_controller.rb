class QuestionAccessesController < ApplicationController
  def index
    retorno = search_date(params[:year], params[:month], params[:week])
    render json: retorno.to_json
  end
end

# Mais acessadas por periodo:
# Listar as questões mais acessadas por semana/mês/ano

# date e times_accessed

# semana
# mes
# ano
#

private

def search_date(year, month, week)
  return QuestionAccess.by_year(year_to_date(year)) if year
  return QuestionAccess.by_month(month_to_date(month)) if month

  QuestionAccess.by_week(week.to_date) if week
end

def month_to_date(month)
  year = month.split('-').first.to_i
  Date.new(year, month.last.to_i, 1)
end

def year_to_date(year)
  Date.new(year.to_i, 1, 1)
end
