require 'rails_helper'

RSpec.describe QuestionObserver, type: :observer do
  subject        { described_class.send(:new) }

  let(:question) { create(:question, :with_answer, :with_subject) }

  describe '#after_touch' do
    

    before { expect(question).to receive(:save).and_return(true) }

    it { expect { subject.after_touch(question) }.to_not raise_error }
  end
end
