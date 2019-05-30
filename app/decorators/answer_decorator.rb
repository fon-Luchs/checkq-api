class AnswerDecorator < ApplicationDecorator
  delegate_all

  def as_json(*args)
    {
      id: object.id,
      title: object.name
    }
  end
end
