class Api::AnswersController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @answer = Answer::Result.new(resource_params)
  end

  def resource
    @answer
  end

  def resource_params
    params.require(:answer).permit(result: [:id, :answer_id])
  end
end
