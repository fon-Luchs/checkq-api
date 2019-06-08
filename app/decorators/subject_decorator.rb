class SubjectDecorator < ApplicationDecorator
  delegate_all

  decorates_associations :questions

  def as_json(*args)
    {
      id: object.id,
      name: object.name,
      question_count: object.questions.count
    }
  end
end
