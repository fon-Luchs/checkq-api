class Api::TestsController < BaseController
  before_action :build_resource, only: :create

  private

  def builde_resource
    @task = Task::TestGenerator.new(resource_params)
  end

  def resource
    @task
  end

  def resource_params
    params.require(:test).permit(:subject_ids, :question_count)
  end
end
