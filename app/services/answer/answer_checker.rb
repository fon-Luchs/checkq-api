class Answer::AnswerChecker
  def self.check(arr)
    result = []
    arr.each do |a|
      result << QuestionAnswer.find_by(question_id: a[:id])
    end
    result
  end
end
