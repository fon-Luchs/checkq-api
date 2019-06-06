require 'rails_helper'

RSpec.describe 'PostUserTest', type: :request do
  let(:headers)     { { 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:subj)        { create(:subject) }

  let(:count)       { 1 }

  let(:task)        { Task::TestGenerator.new(subject_ids: [subj.id], question_count: count) }

  let(:question)    { create(:question, :with_answers, subject: subj) }

  let(:params) do
    {
      test:
      {
        question_count: count.to_s,
        subject_ids: [subj.id.to_s]
      }
    }
  end

  let(:answer_response) do
    question.answers.map do |a|
      {
        'id' => a.id,
        'title' => a.name
      }
    end
  end

  let(:resource_response) do
    subj.questions.map do |q|
      [
        {
          'id' => q.id,
          'options' => answer_response,
          'question' => q.name,
          'rate' => q.rate
        }
      ]
    end
  end

  let(:permitted_params) { permit_params! params, :test }

  context do
    before { expect(Task::TestGenerator).to receive(:new).with(permitted_params).and_return(task) }

    before { post '/api/test', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'invalid params' do
    before { post '/api/test', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
