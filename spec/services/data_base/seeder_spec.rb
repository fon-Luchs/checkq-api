require 'rails_helper'

RSpec.describe DataBase::Seeder do
  subject              { DataBase::Seeder }

  let(:subj)           { create(:subject) }

  let(:subjects_array) { [] }

  describe '#seed' do
    before { expect(subject).to receive(:feel).with(subjects_array).and_return(['aig']) }

    before { expect(subject).to receive(:relation_builder).with(subjects_array).and_return(subj) }

    its(:seed) { should eq subj }
  end
end
