FactoryBot.define do
  factory :question do
    name { '__' + FFaker::Skill.tech_skill }
    subject { nil }
  end
end
