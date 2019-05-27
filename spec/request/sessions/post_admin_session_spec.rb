require 'rails_helper'

RSpec.describe 'PostAdminSession', type: :request do
  let(:headers)  { { 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:user)     { create(:user, state: 2) }

  let(:params)   { { session: { email: user.email, password: user.password } } }

  let(:resource_response) do
    { 'admin_auth_token' => session.as_json[:admin_auth_token] }
  end

  let(:session)          { Session::AdminSession.new(user: user, password: user.password) }

  let(:permitted_params) { permit_params! params, :session }

  context do
    before { expect(Session::AdminSession).to receive(:new).with(user: user, password: user.password).and_return(session) }

    before { post '/api/session', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'invalid params' do
    before { post '/api/session', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
