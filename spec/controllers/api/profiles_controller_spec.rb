require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do
  let(:user) { create(:user) }

  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password,
        password_confirmation: user.password,
        username: user.username,
        state: 1
      }
    }
  end

  let(:permited_params) { permit_params! params, :user }

  let(:headers) do
    {
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#create.json' do
    before { expect(User).to receive(:new).with(permited_params).and_return(user) }

    context 'success' do
      before { expect(user).to receive(:save).and_return(true) }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(user).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'routes test' do
    it { should route(:post, '/api/profile').to(action: :create, controller: 'api/profiles') }
  end
end
