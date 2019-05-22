require 'rails_helper'

RSpec.describe 'GetChatIndex', type: :request do
  let(:headers)   { { 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:subjects) { create_list(:subject, 10) }

  let(:resource_response) do
    Subject.all.map do |s|
      {
        'id' => s.id,
        'name' => s.name,
        'question_count' => s.questions.count,
        'avatar' => 'http://scp-wiki.wdfiles.com/local--files/scp-003/SCP-003a.jpg'
      }
    end
  end

  context do
    before { get '/api/subjects', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end
end
