require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe 'routes test' do
    it { should route(:post, 'api/session').to(action: :create, controller: 'api/sessions') }
  end

  let(:user) { create(:user) }

  let(:session) { Session::SessionAuthorizer.authorize(email: user.email, password: user.password) }

  let(:params) do
    {
      session:
      {
        email: user.email,
        password: user.password
      }
    }
  end

  let(:permitted_params) { permit_params! params, :session }

  describe 'create#json' do
    before { expect(Session::SessionAuthorizer).to receive(:authorize).with(permitted_params).and_return(session) }

    context 'success' do
      before { expect(session).to receive(:save).and_return(true) }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'false' do
      before { expect(session).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end
end
