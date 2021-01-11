class QuestionAccessesController < ApplicationController
  before_action :verify_params

  def index
    render json: service.search.to_json
  end

  private

  def verify_params
    if params[:year].blank? && params[:month].blank? && params[:week].blank?
      render json: { error: I18n.t('question_accesses_controller.index.missing_params') }, status: 400
    end
  end

  def service
    @service ||= QuestionAccessServices.new(params[:year], params[:month], params[:week])
  end
end
