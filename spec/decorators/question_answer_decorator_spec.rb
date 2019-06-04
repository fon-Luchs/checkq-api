require 'rails_helper'

RSpec.describe QuestionAnswerDecorator do
  let(:question) { create(:question, :with_subject) }

  let(:answer)   { create(:answer, question: question) }

  let(:question_answer) { create(:question_answer, question: question, answer: answer) }

  describe '#as_json' do
    subject       { question_answer.decorate.as_json }

    its([:id])    { question.id }

    its([:id_answer]) { answer.id }
  end

  describe '#to_json' do
    subject       { question_answer.decorate.to_json }

    its([:id])    { question.id.to_json }

    its([:id_answer]) { answer.id.to_json }
  end
end
