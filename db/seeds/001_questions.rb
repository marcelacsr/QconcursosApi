return if Question.exists?

response = HTTParty.get('https://raw.githubusercontent.com/qcx/desafio-backend/master/questions.json')

questions = JSON.parse(response)
questions.each_with_index do |q, idx|
  Rails.logger.info("#{idx} Questions processed") if (idx % 100).zero?

  Question.find_or_create_by(
    id: q['id'],
    statement: q['statement'],
    text: q['text'],
    answer: q['answer'],
    daily_access: q['daily_access'],
    discipline: q['discipline'],
    created_at: q['created_at']
  )
rescue ActiveRecord::RecordNotUnique => e
  Rails.logger.warn(e.message)
end
