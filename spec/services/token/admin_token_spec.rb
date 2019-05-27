require 'rails_helper'

RSpec.describe Token::AdminToken do
  let(:user)    { create(:user) }

  let(:payload) { { user_id: user.id } }

  let(:meta) do
    {
      exp: 1.days.from_now.to_i,
      iss: 'admin',
      aud: 'client'
    }
  end

  let(:token_payload) { payload.reverse_merge! meta }

  let(:rsa_private)   { OpenSSL::PKey::RSA.generate(2048) }

  let(:rsa_public)    { rsa_private.public_key }

  subject { Token::AdminToken }

  before {}

  describe '#encode' do
    before { expect(payload).to receive(:reverse_merge!).with(meta).and_return(token_payload) }

    before { stub_const('Token::AdminToken::RSA_PRIVATE', rsa_private) }

    before do
      expect(JWT).to receive(:encode).with(payload, rsa_private, 'RS512').and_return('xxx-yyy-zzz')
    end

    it { expect(subject.encode(payload)).to eq 'xxx-yyy-zzz' }
  end

  describe '#decode' do
    let(:token) { subject.encode(payload) }

    before      { stub_const('Token::AdminToken::RSA_PUBLIC', rsa_public) }

    before do
      expect(JWT).to receive(:decode).with(token, rsa_public, true, { algorithm: 'RS512' }).and_return(token_payload)
    end

    it { expect(subject.decode(token)).to eq token_payload }
  end

  describe '#valid' do
    context 'true' do
      before { expect(subject).to receive(:valid_payload).and_return true }

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
