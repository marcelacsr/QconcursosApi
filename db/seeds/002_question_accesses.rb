return if QuestionAccess.exists?

response = HTTParty.get('https://raw.githubusercontent.com/qcx/desafio-backend/master/question_access.json')

question_accesses = JSON.parse(response)
question_accesses.each_with_index do |q, idx|
  Rails.logger.info("#{idx} QuestionAccess processed") if (idx % 5000).zero?

  QuestionAccess.find_or_create_by(
    question_id: q['question_id'],
    date: q['date'],
    times_accessed: q['times_accessed']
  )
end
