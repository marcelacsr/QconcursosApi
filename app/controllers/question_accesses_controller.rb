class QuestionAccessesController < ApplicationController
  def index
    render json: service.search.to_json
  rescue StandardError => e
    render json: { erro: { message: e.message } }
  end

  private

  def service
    @service ||= QuestionAccessServices.new(params[:year], params[:month], params[:week])
  end
end
