FactoryBot.define do
  factory :user do
    username { 'Walar Morgulis' }

    email    { FFaker::Internet.email }

    password { FFaker::Internet.password }

    state { 1 }
  end
end
