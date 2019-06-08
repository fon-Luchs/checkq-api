require 'rails_helper'

RSpec.describe 'GetBank', type: :request do
  let(:headers)    { { 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:questions) { create_list(:question, 5, :with_subject, :with_correct_answer) }

  let(:resource_response) do
    questions.map do |q|
      {
        'question_id' => q.id,
        'subject_id' => q.subject.id,
        'question_name' => q.name,
        'answer_name' => q.question_answer.answer.name
      }
    end
  end

  context do
    before { get '/api/bank', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end
end
