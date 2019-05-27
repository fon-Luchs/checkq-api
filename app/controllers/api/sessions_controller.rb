class Api::SessionsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @session = Session::SessionAuthorizer.authorize(permitted_params)
  end

  def resource
    @session
  end

  def permitted_params
    params.require(:session).permit(:email, :password)
  end
end
