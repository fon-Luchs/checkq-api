require 'rails_helper'

RSpec.describe Session::SessionAuthorizer do
  let(:user) { create(:user) }

  subject    { Session::SessionAuthorizer }

  describe '#user' do
    let(:params) { { email: user.email, password: user.password } }

    before do
      expect(Session::SessionSetter).to receive_message_chain(:new, :set)
        .with(params).with(no_args)
        .and_return('session')
    end

    it { expect(subject.authorize).to eq('session') }
  end
end
