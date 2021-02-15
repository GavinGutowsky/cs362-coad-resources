FactoryBot.define do
  factory :ticket do
    name { 'Fake Ticket' }
    description { 'Fake description' }
    phone { '+1 541-330-8612' }
    closed { false }
    region
    resource_category

    trait :closed do
      closed { true }
    end

    trait :open do
      closed { false }
    end

    trait :organization do
      organization
    end

    trait :nil_organization do
      organization_id { nil }
    end
  
  end
end