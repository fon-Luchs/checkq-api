class Api::SubjectsController < BaseController
  private

  def collection
    # # puts ">>>#{request.headers['Authorization'].split(' ').last}"
    # authenticate_or_request_with_http_token do |token, options|
    #   puts "#{token.split(' ')}"
    # end
    @subjects = Subject.all
  end
end
