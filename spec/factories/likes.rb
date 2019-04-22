FactoryBot.define do
  factory :like do
    user
    trait :comment do
      association :likeable, factory: :comment
    end
    trait :post do
      association :likeable, factory: :post
    end
  end
end
