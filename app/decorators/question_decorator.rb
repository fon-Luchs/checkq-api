class QuestionDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :answers

  def as_json(*args)
    {
      id: object.id,
      question: object.name,
      options: answers.as_json
    }
  end
end
