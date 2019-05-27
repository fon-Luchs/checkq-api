class Token::BaseToken
  def self.encode(payload)
    payload.reverse_merge!(meta)
    encrypt_algo payload
  end

  def self.decode(token)
    decode_algo token
  end

  def self.valid_payload(payload)
    if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
      false
    else
      true
    end
  end
end
