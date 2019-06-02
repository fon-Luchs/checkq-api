require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:subject) }

  it { should have_many(:answers) }

  it { should have_one(:question_answer) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(4500) }
end
