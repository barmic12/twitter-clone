FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(10) }
    user
  end
end
