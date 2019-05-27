class Session::UserSession < Session::BaseSession
  private

  def token
    @token ||= Token::UserToken.encode payload
    @token
  end

  def as_json_token
    { user_auth_token: token }
  end
end
