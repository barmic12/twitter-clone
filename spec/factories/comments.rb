FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.characters(10) }
    user
    post
  end
end
