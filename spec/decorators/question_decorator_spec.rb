require 'rails_helper'

RSpec.describe QuestionDecorator do
  let(:question) { create(:question, :with_subject, :with_answers) }

  describe do
    subject          { question.decorate.as_json }

    its([:id])       { question.id }

    its([:question]) { question.name }

    its([:rate])     { question.rate }

    its([:options])  { question.answers.decorate.as_json }
  end
end
