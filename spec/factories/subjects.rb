FactoryBot.define do
  factory :subject do
    name { '__' + FFaker::Skill.tech_skill }

    trait :with_questions do
      after :create do |subject|
        create_list :question, 100, :with_answers, subject: subject
      end
    end
  end
end
