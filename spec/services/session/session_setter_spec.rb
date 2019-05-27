require 'rails_helper'

RSpec.describe Session::SessionSetter do
  let(:user) { create(:user) }

  subject    { Session::SessionSetter.new(email: user.email, password: user.password) }

  describe '#user' do
    before     { expect(subject).to receive(:user).and_return(user) }

    its(:user) { should eq user }
  end

  describe '#session_params' do
    before               { expect(subject).to receive(:session_params).and_return('args') }

    its(:session_params) { should eq 'args' }
  end

  describe '#set' do
    context '#valid?false' do
      let(:session) { Session::SessionSetter.new(email: '', password: user.password) }

      subject { session.errors }

      before  { expect(User).to receive(:find_by).with(email: '').and_return(nil) }

      before  { session.valid? }

      its([:email]) { should eq ['not found'] }
    end

    context '#valid?true' do
      before    { expect(User).to receive(:find_by).with(email: user.email).and_return(user) }

      before    { expect(user).to receive(:user?).and_return(true) }

      before    { expect(Session::UserSession).to receive(:new).with(user: user, password: user.password).and_return('session') }

      its(:set) { should eq 'session' }
    end
  end
end
