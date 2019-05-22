require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(250) }
end
