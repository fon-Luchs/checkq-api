require 'rails_helper'

RSpec.describe Answer::AnswerChecker do
  let(:question) { create(:question, :with_subject) }

  let(:answer)   { create(:answer, question: question) }

  let(:question_answer) { create(:question_answer, answer: answer, question: question) }

  let(:params)          { [{ id: question.id }] }

  subject { Answer::AnswerChecker }

  describe '#check' do
    before { expect(QuestionAnswer).to receive(:find_by).with(question_id: question.id).and_return(question_answer) }

    it { expect { subject.check(params) }.to_not raise_error }
  end
end
