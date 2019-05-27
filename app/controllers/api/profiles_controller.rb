class Api::ProfilesController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @profile = User.new(resource_params)
  end

  def resource
    @profile
  end

  def resource_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :username
    ).merge(state: 1)
  end
end
