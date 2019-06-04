require 'rails_helper'

RSpec.describe 'PostUserTestResult', type: :request do
  let(:headers)  { { 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:question) { create(:question, :with_subject) }

  let(:answer)   { create(:answer, question: question) }

  let!(:question_answer) { create(:question_answer, question: question, answer: answer) }

  let(:result)           { Answer::Result.new(result: [{id: question.id, answer_id: answer.id}]) }

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

  let(:resource_response) do
    {
      'id' => question.id,
      'id_answer' => answer.id
    }
  end

  let(:permitted_params) { permit_params! params, :answer }

  context do
    before { expect(Answer::Result).to receive(:new).with(permitted_params).and_return(result) }

    before { post '/api/answer', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'invalid params' do
    before { post '/api/answer', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
