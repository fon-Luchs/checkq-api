class QuestionAnswerDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :answer

  decorates_associations :question

  def as_json(*args)
    {
      id: question.id,

      id_answer: answer.id
    }
  end

  def to_json(*args)
    as_json.to_json
  end
end
