class Api::SubjectsController < BaseController
  private

  def collection
    @subjects = Subject.all
  end
end
