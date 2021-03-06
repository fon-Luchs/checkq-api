require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should have_many(:questions) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_least(4).is_at_most(35) }
end
