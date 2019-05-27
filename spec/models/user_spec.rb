require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }

  it { should validate_length_of(:username).is_at_least(3).is_at_most(15) }

  it { should define_enum_for(:state) }

  it { should validate_uniqueness_of(:username).ignoring_case_sensitivity }

  it { should validate_presence_of(:username) }

  it { should validate_presence_of(:email) }
end
