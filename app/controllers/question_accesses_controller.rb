class QuestionAccessesController < ApplicationController
  def index
    # tratar caso params nil
    render json: service.search.to_json
  end

  private

  def service
    @service ||= QuestionAccessServices.new(params[:year], params[:month], params[:week])
  end
end
