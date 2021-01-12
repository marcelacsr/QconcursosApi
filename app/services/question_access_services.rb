class QuestionAccessServices
  attr_reader :year, :month, :week

  def initialize(year, month, week)
    @year = year
    @month = month
    @week = week

    raise ArgumentError, 'Only dates are allowed' unless valid_params?
  end

  def search
    query.map { |k, v| { question_id: k, times_accessed: v } }
  end

  private

  def valid_params?
    return false if [week.blank?, month.blank?, year.blank?].all?

    result_year = year.nil? || /(^\d{4}$)/.match?(year)
    result_month = month.nil? || /(^\d{4}-(0?[1-9]|1[012])$)/.match?(month)
    result_week = week.nil? || Date.strptime(week, '%Y-%m-%d')

    return false if !result_year || !result_month || !result_week

    true
  rescue StandardError
    false
  end

  def query
    query ||= QuestionAccess.by_year(year_to_date) if year.present?
    query ||= QuestionAccess.by_month(month_to_date) if month.present?
    query ||= QuestionAccess.by_week(week.to_date) if week.present?

    return [] if query.blank?

    query.group(:question_id).sum(:times_accessed)
  end

  def month_to_date
    date_year, date_month = month.split('-')
    Date.new(date_year.to_i, date_month.to_i, 1)
  end

  def year_to_date
    Date.new(year.to_i, 1, 1)
  end
end
