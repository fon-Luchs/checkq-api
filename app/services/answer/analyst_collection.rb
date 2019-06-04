class Answer::AnalystCollection
  def self.collect(arr)
    arr.each do |result|
      answer = Answer.find(result[:answer_id])
      question = Question.find(result[:id])

      if QuestionAnswer.find_by(answer: answer, question: question).nil?
        question.increment!(:fail_atempts, coef)
      else
        question.increment!(:success_atempts, coef)
      end
    end
  end

  def self.coef
    1
  end
end
