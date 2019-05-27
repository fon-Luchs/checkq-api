require 'rails_helper'

RSpec.describe Session::AdminSession do
  let(:user) { create(:user) }

  subject    { Session::AdminSession.new(user: user, password: user.password) }

  describe '#password?' do
    context do
      before          { expect(user).to receive(:authenticate).with(user.password).and_return(true) }

      its(:password?) { should eq true }
    end

    context do
      before          { expect(user).to receive(:authenticate).with(user.password).and_return(false) }

      its(:password?) { should eq false }
    end
  end

  describe '#valid?' do
    let(:session) { Session::AdminSession.new user: user, password: user.password }

    subject       { session.errors }

    context do
      before { expect(session).to receive(:password?).and_return(false) }

      before { session.valid? }

      its([:password]) { should eq ['is invalid'] }
    end
  end

  describe '#save' do
    context do
      before     { expect(subject).to receive(:valid?).and_return(false) }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(Token::AdminToken).to receive(:encode).with(user_id: user.id).and_return('x-y-z') }

      its(:save) { should eq true }
    end
  end

  describe '#as_json' do
    before        { expect(subject).to receive(:as_json).and_return(user_auth_token: 'xxxx-yyyy-zzzz') }

    its(:as_json) { should eq user_auth_token: 'xxxx-yyyy-zzzz' }
  end
end
