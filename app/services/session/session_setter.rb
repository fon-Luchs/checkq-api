class Session::SessionSetter
  include ActiveModel::Validations

  def initialize(params = {})
    params ||= {}

    @email = params[:email]

    @password = params[:password]
  end

  def set
    if valid?
      @session = Session::AdminSession.new(session_params) if user.admin?
      @session = Session::UserSession.new(session_params) if user.user?
    end
    @session || self
  end

  validate do |model|
    model.errors.add :email, 'not found' unless user
  end

  private

  def user
    @user ||= User.find_by email: @email
  end

  def session_params
    { user: user, password: @password }
  end
end
