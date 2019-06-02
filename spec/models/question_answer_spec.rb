require 'rails_helper'

RSpec.describe QuestionAnswer, type: :model do
  it { should belong_to(:answer) }

  it { should belong_to(:question) }
end
