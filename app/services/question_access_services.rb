class QuestionAccessServices
  attr_reader :year, :month, :week

  def initialize(year, month, week)
    @year = year
    @month = month
    @week = week
  end

  def search
    query.map { |k, v| { question_id: k, times_accessed: v } }
  end

  private

  def query
    query ||= QuestionAccess.by_year(year_to_date(year)) if year
    query ||= QuestionAccess.by_month(month_to_date(month)) if month
    query ||= QuestionAccess.by_week(week.to_date) if week

    return [] if query.blank?

    query.group(:question_id).sum(:times_accessed)
  end

  def month_to_date(month)
    year = month.split('-').first.to_i
    Date.new(year, month.last.to_i, 1)
  end

  def year_to_date(year)
    Date.new(year.to_i, 1, 1)
  end
end
