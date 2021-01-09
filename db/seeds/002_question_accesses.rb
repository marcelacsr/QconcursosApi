response = HTTParty.get('https://raw.githubusercontent.com/qcx/desafio-backend/master/question_access.json')

question_accesses = JSON.parse(response)
question_accesses.each do |q|
  QuestionAccess.find_or_create_by(
    question_id: q['question_id'],
    date: q['date'],
    times_accessed: q['times_accessed']
  )
end
