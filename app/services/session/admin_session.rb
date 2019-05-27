class Session::AdminSession < Session::BaseSession
  private

  def token
    @token ||= Token::AdminToken.encode payload
    @token
  end

  def as_json_token
    { admin_auth_token: token }
  end
end
