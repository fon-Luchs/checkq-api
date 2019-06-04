require 'rails_helper'

RSpec.describe 'PostUserTest', type: :request do
  let(:headers)     { { 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:subjects)    { create_list(:subject, 2, :with_questions) }

  let(:count)       { 4 }

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

  let(:subject_answers) do

  end

  let(:resource_response) do
    subjects.map do |element|
      element.questions.order(rate: :asc).first(count / subjects.size).map do |q|
        {
          'id' => q.id,
          'question' => q.name,
          'rate' => q.rate,
          'options' => q.answers.map do |a|
                         {
                           'id' => a.id,
                           'title' => a.name
                         }
                       end
        }
      end
    end.flatten.sort_by!{ |h| h['rate'] }.reverse!
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
