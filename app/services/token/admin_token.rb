class  Token::AdminToken < Token::BaseToken
  RSA_PRIVATE = OpenSSL::PKey::RSA.generate(2048).freeze

  RSA_PUBLIC = RSA_PRIVATE.public_key.freeze

  def self.encrypt_algo(payload)
    JWT.encode payload, RSA_PRIVATE, 'RS512'
  end

  def self.decode_algo(token)
    JWT.decode token, RSA_PUBLIC, true, { algorithm: 'RS512' }
  end

  def self.meta
    {
      exp: 1.days.from_now.to_i,
      iss: 'admin',
      aud: 'client'
    }
  end

  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end

  private_class_method :decode_algo, :encrypt_algo, :meta, :expired

  private_constant :RSA_PRIVATE, :RSA_PUBLIC
end
