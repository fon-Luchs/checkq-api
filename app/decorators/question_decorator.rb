class QuestionDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :answers

  decorates_associations :subject

  decorates_associations :question_answer

  def as_json(*args)
    if context[:bank_json]
      {
        question_id: object.id,
        subject_id: subject.id,
        question_name: object.name,
        answer_name: question_answer.answer.name
      }
    else
    {
      id: object.id,
      question: object.name,
      options: answers.as_json
    }
    end
  end
end
