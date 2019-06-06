require 'rails_helper'

RSpec.describe Task::QuestionParser do
  let(:subjects) { create_list(:subject, 5, :with_questions) }

  let(:count)    { 15 }

  subject { Task::QuestionParser.parse(count, subjects) }

  describe '#parse' do
    context 'count' do
      it { expect(subject.size).to eq count }
    end

    context '#as_json' do
      subject { Task::QuestionParser }

      let(:questions) { double }

      before { expect(subject).to receive(:questions).and_return(questions) }

      before { expect(questions).to receive(:shuffle).and_return(questions) }

      it { expect(subject.parse(count, subjects)).to eq questions }
    end
  end
end
