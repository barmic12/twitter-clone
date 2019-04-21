FactoryBot.define do
  factory :user do
    username { Faker::Books::Dune.character }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(10) }
  end
end
