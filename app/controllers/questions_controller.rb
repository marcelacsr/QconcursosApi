class QuestionsController < ApplicationController
  def index
    disciplines =
      Question
      .order_sum_by_discipline
      .map { |k, v| { discipline: k, daily_access: v } }

    render json: disciplines.to_json
  end
end
