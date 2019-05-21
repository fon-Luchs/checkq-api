FactoryBot.define do
  factory :subject do
    name { '__' + FFaker::Skill.tech_skill }
  end
end
