class Answer::AnalystCollection
  def self.collect(arr)
    arr.each do |result|
      question = Question.find(result[:id])
      question.increment!(:rolls_count, coef)

      if QuestionAnswer.find_by(answer_id: result[:answer_id], question: question).nil?
        question.increment!(:fail_atempts, coef)
      else
        question.increment!(:success_atempts, coef)
      end

      question.touch
    end
  end

  def self.coef
    1
  end
end
