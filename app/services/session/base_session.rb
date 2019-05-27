class Session::BaseSession
  include ActiveModel::Validations

  def initialize(params = {})
    params ||= {}

    @user = params[:user]

    @password = params[:password]
  end

  validate do |model|
    if @user
      model.errors.add :password, 'is invalid' unless password?
    end
  end

  def save
    return false unless valid?

    token && true
  end

  def as_json(*args)
    as_json_token
  end

  def to_json(*args)
    as_json.to_json
  end

  private

  def payload
    { user_id: @user.id }
  end

  def password?
    @user.authenticate @password
  end
end
