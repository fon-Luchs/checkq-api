require 'rails_helper'

RSpec.describe Token::UserToken do
  let(:user)    { create(:user) }

  let(:payload) { { user_id: user.id } }

  let(:meta) do
    {
      exp: 7.days.from_now.to_i,
      iss: 'user',
      aud: 'client'
    }
  end

  let(:token_payload) { payload.reverse_merge! meta }

  let(:secret)        { 'pls_dn\'t_h4ck_ths ' }

  subject { Token::UserToken }

  describe '#encode' do
    before { expect(payload).to receive(:reverse_merge!).with(meta).and_return(token_payload) }

    before do
      expect(JWT).to receive(:encode).with(token_payload, secret, 'HS512').and_return('xxx-yyy-zzz')
    end

    it { expect(subject.encode(payload)).to eq 'xxx-yyy-zzz' }
  end

  describe '#decode' do
    let(:token) { subject.encode(payload) }

    before do
      expect(JWT).to receive(:decode).with(token, secret, true, { algorithm: 'HS512' }).and_return(token_payload)
    end

    it { expect(subject.decode(token)).to eq token_payload }
  end

  describe '#valid' do
    context 'true' do
      before { allow(subject).to receive(:valid_payload).and_return true }

      it     { expect(subject.valid_payload(token_payload)).to eq true }
    end

    context 'false' do
      let(:meta) do
        {
          exp: Time.now - 10000000,
          iss: '',
          aud: ''
        }
      end

      let(:token_payload) { payload.reverse_merge! meta }

      let(:time)          { Time.now }

      before              { allow(Time).to receive(:now).and_return(time) }

      before { expect(Time).to receive_message_chain(:at, :<).with(token_payload[:exp]).with(Time.now).and_return(false) }

      it     { expect(subject.valid_payload(token_payload)).to eq false }
    end
  end
end
