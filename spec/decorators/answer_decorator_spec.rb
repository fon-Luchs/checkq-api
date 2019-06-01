require 'rails_helper'

RSpec.describe AnswerDecorator do
  let(:answer) { create(:answer, :with_question) }

  describe do
    subject      { answer.decorate.as_json }

    its([:id])   { answer.id }

    its([:title]) { answer.name }
  end
end
