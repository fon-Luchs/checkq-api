class Session::SessionAuthorizer
  def self.authorize(params = {})
    params ||= {}

    Session::SessionSetter.new(params).set
  end
end
