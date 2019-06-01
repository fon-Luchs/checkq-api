require 'rails_helper'

RSpec.describe Api::TestsController, type: :controller do
  describe 'routes test' do
    it { should route(:post, 'api/test').to(action: :create, controller: 'api/tests') }
  end

  let(:subjects)    { create_list(:subject, 5, :with_questions) }

  let(:count)       { 15 }

  let(:task)        { Task::TestGenerator.new(subject_ids: subjects.map(&:id), question_count: count) }

  let(:params) do
    {
      test:
      {
        question_count: count.to_s,
        subject_ids: subjects.map(&:id).map(&:to_s)
      }
    }
  end

  let(:permitted_params) { permit_params! params, :test }

  describe 'create#json' do
    before { expect(Task::TestGenerator).to receive(:new).with(permitted_params).and_return(task) }

    context 'success' do
      before { expect(task).to receive(:save).and_return(true) }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'false' do
      before { expect(task).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end
end
