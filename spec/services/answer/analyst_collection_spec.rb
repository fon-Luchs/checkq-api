require 'rails_helper'

RSpec.describe Answer::AnalystCollection do
  let(:question) { create(:question, :with_subject, :with_answer) }

  let(:answer)   { create(:answer, question: question) }

  let(:question_answer) { create(:question_answer, answer: answer, question: question) }

  let(:params) { [{ id: question.id, answer_id: answer.id }] }

  let(:coef)   { 1 }

  subject { Answer::AnalystCollection }

  describe '#collect#true' do
    before { expect(Answer).to receive(:find).with(answer.id).and_return(answer) }

    before { expect(Question).to receive(:find).with(question.id).and_return(question) }

    before do
      expect(QuestionAnswer).to receive_message_chain(:find_by, :nil?)
        .with(answer: answer, question: question)
        .with(no_args)
        .and_return(false)
    end

    before { expect(question).to receive(:increment!).with(:success_atempts, coef).and_return(true) }

    it { expect { subject.collect(params) }.to_not raise_error }
  end

  describe '#collect#false' do
    before { expect(Answer).to receive(:find).with(answer.id).and_return(answer) }

    before { expect(Question).to receive(:find).with(question.id).and_return(question) }

    before do
      expect(QuestionAnswer).to receive_message_chain(:find_by, :nil?)
        .with(answer: answer, question: question)
        .with(no_args)
        .and_return(true)
    end

    before { expect(question).to receive(:increment!).with(:fail_atempts, coef).and_return(true) }

    it { expect { subject.collect(params) }.to_not raise_error }
  end
end
