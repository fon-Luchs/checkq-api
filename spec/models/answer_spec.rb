require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should have_one(:question_answer) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(2500) }
end
