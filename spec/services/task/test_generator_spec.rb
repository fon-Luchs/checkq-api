require 'rails_helper'

RSpec.describe Task::TestGenerator do
  let(:subjects) { create_list(:subject, 5, :with_questions) }

  let(:count)    { 15 }

  subject        { Task::TestGenerator.new(subject_ids: Subject.all.ids, question_count: count) }

  describe '#valid?' do
    let(:test) { Task::TestGenerator.new(subject_ids: Subject.all.ids, question_count: count) }

    subject    { test.errors }

    context ':subject' do
      before { test.valid? }

      before { expect(test).to receive(:invalid_question_count?).and_return(true) }

      before { test.valid? }

      its([:question_count]) { should eq ['is invalid'] }
    end

    context ':question_count' do
      before { expect(test).to receive_message_chain(:subjects, :any?).and_return(true) }

      before { test.valid? }

      its([:subject]) { should eq ['is not found in this life'] }
    end
  end

  describe '#save' do
    context do
      before     { expect(subject).to receive(:valid?).and_return(false) }

      its(:save) { should eq false }
    end

    context do
      let(:subjects) { double }

      before { expect(subject).to receive(:subjects).and_return(subjects) }

      before { expect(subject).to receive(:valid?).and_return(true) }

      its(:save) { should eq true }
    end
  end

  describe '#to_json' do
    before do
      expect(Task::QuestionParser).to receive(:parse)
        .with(count, subjects)
        .and_return(['xxx'])
    end

    its(:to_json) { should eq "[\"xxx\"]" }
  end
end
