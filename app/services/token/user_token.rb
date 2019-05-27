class  Token::UserToken < Token::BaseToken
  private_class_method def self.encrypt_algo(payload)
    JWT.encode payload, secret, 'HS512'
  end

  private_class_method def self.decode_algo(token)
    JWT.decode token, secret, true, { algorithm: 'HS512' }
  end

  private_class_method def self.meta
    {
      exp: 7.days.from_now.to_i,
      iss: 'user',
      aud: 'client'
    }
  end

  private_class_method def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end

  private_class_method def self.secret
    'pls_dn\'t_h4ck_ths '
  end
end
