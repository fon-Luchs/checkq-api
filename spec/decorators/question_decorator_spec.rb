require 'rails_helper'

RSpec.describe QuestionDecorator do
  let(:question) { create(:question, :with_subject, :with_answers) }

  let(:answer)   { create(:answer, question: question) }

  let!(:question_answer) { create(:question_answer, question: question, answer: answer) }

  describe do
    subject          { question.decorate.as_json }

    its([:id])       { question.id }

    its([:question]) { question.name }

    its([:options])  { question.answers.decorate.as_json }
  end

  describe ':bank_json' do
    subject          { question.decorate(context: { bank_json: true}).as_json }

    its([:question_id]) { should eq question.id }

    its([:subject_id]) { should eq question.subject.id }

    its([:question_name]) { should eq question.name }

    its([:answer_name]) { should eq answer.name }
  end
end
