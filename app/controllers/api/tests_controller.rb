class Api::TestsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @task = Task::TestGenerator.new(resource_params)
  end

  def resource
    @task
  end

  def resource_params
    params.require(:test).permit(:question_count, subject_ids: [])
  end
end
