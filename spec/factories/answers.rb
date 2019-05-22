FactoryBot.define do
  factory :answer do
    name { '__' + FFaker::Skill.tech_skill }
    question { nil }
  end
end
