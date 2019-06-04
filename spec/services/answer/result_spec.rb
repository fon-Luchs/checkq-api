require 'rails_helper'

RSpec.describe Answer::Result do
  let(:question) { create(:question, :with_subject) }

  let(:answer)   { create(:answer, question: question) }

  let(:question_answer) { create(:question_answer, answer: answer, question: question) }

  let(:params)          { { result: [{ id: question.id, answer_id: answer.id }] } }

  subject { Answer::Result.new params }

  describe '#valid?' do
    let(:result) { Answer::Result.new params }

    subject { result.errors }

    context ':answers' do
      before { expect(result).to receive_message_chain(:answers, :any?).and_return(true) }

      before { result.valid? }

      its([:answer_result]) { should eq ['have invalid options'] }
    end

    context ':questions' do
      before { expect(result).to receive_message_chain(:questions, :any?).and_return(true) }

      before { result.valid? }

      its([:answer_result]) { should eq ['have invalid options'] }
    end
  end

  describe '#save' do
    context do
      before     { expect(subject).to receive(:valid?).and_return(false) }

      its(:save) { should eq false }
    end

    context do
      let(:result) { double }

      before { expect(subject).to receive(:results).and_return(result) }

      before { expect(subject).to receive(:valid?).and_return(true) }

      its(:save) { should eq true }
    end
  end

  describe '#to_json' do
    let(:result) { double }

    before { expect(Answer::AnswerChecker).to receive(:check).with(params[:result]).and_return(result) }

    before { expect(result).to receive(:map).and_return(['res'])}

    its(:to_json) { should eq ['res'] }
  end
end
