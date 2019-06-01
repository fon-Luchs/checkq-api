FactoryBot.define do
  factory :answer do
    name     { '__' + FFaker::Skill.tech_skill }

    question { nil }

    trait :with_question do
      association :question, :with_subject
    end
  end
end
