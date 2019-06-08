class Api::BanksController < BaseController
  private

  def resource
    @bank = Question.all
  end
end
