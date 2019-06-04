require 'rails_helper'

RSpec.describe Api::AnswersController, type: :controller do
  describe 'routes test' do
    it { should route(:post, 'api/answer').to(action: :create, controller: 'api/answers') }
  end

  let(:question) { create(:question, :with_subject) }

  let(:answer)   { create(:answer, question: question) }

  let(:result)   { Answer::Result.new(result: [{id: question.id, answer_id: answer.id}]) }

  let(:params) do
    {
      answer:
      {
        result: [{
          id: question.id.to_s,
          answer_id: answer.id.to_s
        }]
      }
    }
  end

  let(:permitted_params) { permit_params! params, :answer }

  describe 'create#json' do
    before { expect(Answer::Result).to receive(:new).with(permitted_params).and_return(result) }

    context 'success' do
      before { expect(result).to receive(:save).and_return(true) }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'false' do
      before { expect(result).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end
end
