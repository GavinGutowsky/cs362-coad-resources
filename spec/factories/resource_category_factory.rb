FactoryBot.define do
  factory :resource_category do
    sequence(:name) { |n| "Fake Resource Category #{n}" }
    active { false }

    trait :active do
      active { true }
    end

    trait :inactive do
      active { false }
    end
  
  end
end