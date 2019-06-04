FactoryBot.define do
  factory :question do
    name            { '__' + FFaker::Skill.tech_skill }

    subject         { nil }

    success_atempts { 0 }

    fail_atempts    { 0 }

    rate            { rand 1500 }

    trait :with_answers do
      after :create do |question|
        create_list :answer, 4, question: question
      end
    end

    trait :with_subject do
      association :subject
    end

    trait :with_answer do
      after :create do |question|
        create :answer, question: question
      end
    end
  end
end
